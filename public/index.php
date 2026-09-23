<?php
require_once __DIR__ . '/../includes/config.php';
require_once __DIR__ . '/../includes/functions.php';
require_once __DIR__ . '/../includes/auth.php';

$db = Database::getInstance()->getConnection();

// Get search parameter
$searchQuery = isset($_GET['search']) ? sanitize($_GET['search']) : '';
$searchResults = [];
$searchPerformed = false;

// Perform search if query exists
if (!empty($searchQuery)) {
    $searchPerformed = true;
    $searchTerm = '%' . $searchQuery . '%';
    
    // Search in books
    $bookStmt = $db->prepare("
        SELECT b.*, s.name as specialty_name, 'book' as item_type 
        FROM books b 
        JOIN specialties s ON b.specialty_id = s.id 
        WHERE b.status = 'approved' 
        AND (b.title LIKE ? OR b.author LIKE ? OR b.description LIKE ? OR b.publisher LIKE ?)
        ORDER BY b.title
    ");
    $bookStmt->bind_param("ssss", $searchTerm, $searchTerm, $searchTerm, $searchTerm);
    $bookStmt->execute();
    $bookResults = $bookStmt->get_result()->fetch_all(MYSQLI_ASSOC);
    $bookStmt->close();
    
    // Search in journals
    $journalStmt = $db->prepare("
        SELECT j.*, s.name as specialty_name, 'journal' as item_type 
        FROM journals j 
        JOIN specialties s ON j.specialty_id = s.id 
        WHERE j.status = 'approved' 
        AND (j.title LIKE ? OR j.journal_name LIKE ? OR j.abstract LIKE ? OR j.doi LIKE ?)
        ORDER BY j.title
    ");
    $journalStmt->bind_param("ssss", $searchTerm, $searchTerm, $searchTerm, $searchTerm);
    $journalStmt->execute();
    $journalResults = $journalStmt->get_result()->fetch_all(MYSQLI_ASSOC);
    $journalStmt->close();
    
    // Merge results
    $searchResults = array_merge($bookResults, $journalResults);
    
    // Sort results by relevance
    usort($searchResults, function($a, $b) use ($searchQuery) {
        $aScore = 0;
        $bScore = 0;
        $queryLower = strtolower($searchQuery);
        
        if (stripos($a['title'], $searchQuery) !== false) $aScore += 10;
        if (stripos($b['title'], $searchQuery) !== false) $bScore += 10;
        
        if (strtolower($a['title']) === $queryLower) $aScore += 5;
        if (strtolower($b['title']) === $queryLower) $bScore += 5;
        
        return $bScore - $aScore;
    });
}

// Get all specialties with content count - Order by total count (highest to lowest)
$specialtiesWithContent = $db->query("
    SELECT s.*, 
        (SELECT COUNT(*) FROM books WHERE specialty_id = s.id AND status = 'approved') as book_count,
        (SELECT COUNT(*) FROM journals WHERE specialty_id = s.id AND status = 'approved') as journal_count,
        ((SELECT COUNT(*) FROM books WHERE specialty_id = s.id AND status = 'approved') + 
         (SELECT COUNT(*) FROM journals WHERE specialty_id = s.id AND status = 'approved')) as total_count
    FROM specialties s
    WHERE s.status = 1
    AND (
        EXISTS (SELECT 1 FROM books WHERE specialty_id = s.id AND status = 'approved')
        OR EXISTS (SELECT 1 FROM journals WHERE specialty_id = s.id AND status = 'approved')
    )
    ORDER BY total_count DESC, s.name
")->fetch_all(MYSQLI_ASSOC);

// Get latest books (6)
$latestBooks = $db->query("
    SELECT b.*, s.name as specialty_name 
    FROM books b 
    JOIN specialties s ON b.specialty_id = s.id 
    WHERE b.status = 'approved' 
    ORDER BY b.created_at DESC LIMIT 6
")->fetch_all(MYSQLI_ASSOC);

// Get latest journals (6)
$latestJournals = $db->query("
    SELECT j.*, s.name as specialty_name 
    FROM journals j 
    JOIN specialties s ON j.specialty_id = s.id 
    WHERE j.status = 'approved' 
    ORDER BY j.created_at DESC LIMIT 6
")->fetch_all(MYSQLI_ASSOC);

// Get statistics
$stats = [
    'books' => $db->query("SELECT COUNT(*) as count FROM books WHERE status = 'approved'")->fetch_assoc()['count'],
    'journals' => $db->query("SELECT COUNT(*) as count FROM journals WHERE status = 'approved'")->fetch_assoc()['count'],
    'specialties' => count($specialtiesWithContent),
];

// Get only first 5 specialties for display
$displaySpecialties = array_slice($specialtiesWithContent, 0, 5);
$totalSpecialties = count($specialtiesWithContent);
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>UCLP Academy - Medical Books & Journals</title>
    
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
    <!-- Google Fonts - Cambria -->
    <link href="https://fonts.googleapis.com/css2?family=Cambria&display=swap" rel="stylesheet">
    
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        
        body {
            font-family: 'Cambria', Georgia, serif;
            background: #f5f7fa;
            color: #1a1a2e;
        }
        
        /* ============================================
           MAIN LAYOUT - TWO COLUMN
           ============================================ */
        .main-wrapper {
            padding: 25px 0 10px;
            min-height: calc(100vh - 140px);
        }
        
        /* ============================================
           LEFT COLUMN - 35% CATEGORIES (Only 4)
           ============================================ */
        .categories-sidebar {
            background: #ffffff;
            border-radius: 8px;
            border: 1px solid #eef1f5;
            padding: 18px 16px;
            position: sticky;
            top: 75px;
            box-shadow: 0 1px 3px rgba(0,0,0,0.02);
        }
        
        .categories-sidebar .header {
            font-weight: 700;
            font-size: 1.1rem;
            color: #1a1a2e;
            padding-bottom: 10px;
            border-bottom: 1px solid #eef1f5;
            margin-bottom: 10px;
            font-family: 'Cambria', Georgia, serif;
        }
        .categories-sidebar .header i { 
            color: #0d6efd; 
            margin-right: 8px;
        }
        
        .category-item {
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 6px 0;
            text-decoration: none;
            color: #4a4a5e;
            font-family: 'Cambria', Georgia, serif;
            cursor: pointer;
            font-size: 1rem;
            border-bottom: 1px solid #f5f7fa;
        }
        .category-item:last-of-type {
            border-bottom: none;
        }
        .category-item:hover {
            color: #0d6efd;
        }
        .category-item .name {
            font-size: 0.95rem;
            font-weight: 500;
        }
        .category-item .badge-count {
            font-size: 0.7rem;
            background: #e9ecef;
            padding: 1px 8px;
            border-radius: 10px;
            color: #6c757d;
            min-width: 20px;
            text-align: center;
        }
        .category-item:hover .badge-count {
            background: #d4e2fc;
            color: #0d6efd;
        }
        
        .view-all-categories {
            margin-top: 10px;
            padding-top: 10px;
            border-top: 1px solid #eef1f5;
        }
        .view-all-categories .btn {
            font-family: 'Cambria', Georgia, serif;
            font-weight: 600;
            border-radius: 6px;
            padding: 5px 10px;
            font-size: 0.9rem;
            width: 100%;
        }
        
        /* ============================================
           RIGHT COLUMN - 65% CONTENT
           ============================================ */
        .right-content {
            padding-left: 0;
        }
        
        /* Brand Card */
        .brand-card {
            background: #ffffff;
            border-radius: 8px;
            border: 1px solid #eef1f5;
            padding: 20px 24px;
            margin-bottom: 16px;
            box-shadow: 0 1px 3px rgba(0,0,0,0.02);
            text-align: center;
        }
        .brand-card .logo {
            font-size: 2rem;
            font-weight: 700;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 10px;
            font-family: 'Cambria', Georgia, serif;
            color: #1a1a2e;
        }
        .brand-card .logo i { 
            font-size: 2.4rem; 
            color: #0d6efd;
        }
        .brand-card .tagline {
            font-size: 1rem;
            color: #6c757d;
            margin-top: 2px;
            font-family: 'Cambria', Georgia, serif;
        }
        .brand-card .powered {
            font-size: 0.8rem;
            color: #adb5bd;
            margin-top: 4px;
            font-family: 'Cambria', Georgia, serif;
        }
        .brand-card .logo-image {
            height: 115px;
            width: auto;
            display: block;
            margin: 0 auto;
        }
        
        /* Statistics Cards */
        .stats-grid {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 12px;
            margin-bottom: 0;
        }
        .stat-card {
            background: #ffffff;
            border-radius: 8px;
            padding: 14px 12px;
            border: 1px solid #eef1f5;
            text-align: center;
            transition: all 0.2s ease;
            box-shadow: 0 1px 3px rgba(0,0,0,0.02);
        }
        .stat-card:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(0,0,0,0.04);
        }
        .stat-card .icon {
            font-size: 2rem;
            margin-bottom: 4px;
        }
        .stat-card .icon.blue { color: #0d6efd; }
        .stat-card .icon.green { color: #198754; }
        .stat-card .icon.purple { color: #6f42c1; }
        
        .stat-card .number {
            font-size: 2.2rem;
            font-weight: 700;
            color: #1a1a2e;
            line-height: 1.2;
            font-family: 'Cambria', Georgia, serif;
        }
        .stat-card .label {
            font-size: 0.85rem;
            color: #6c757d;
            font-weight: 500;
            font-family: 'Cambria', Georgia, serif;
        }
        
        /* ============================================
           SEARCH SECTION - FULL WIDTH
           ============================================ */
        .search-section {
            margin-top: 20px;
            padding: 18px 0 10px;
            background: transparent;
        }
        .search-section .search-wrapper {
            max-width: 100%;
            margin: 0 auto;
            padding: 0;
        }
        .search-section .search-title {
            font-weight: 700;
            font-size: 1.1rem;
            color: #1a1a2e;
            margin-bottom: 10px;
            font-family: 'Cambria', Georgia, serif;
            display: flex;
            align-items: center;
            gap: 8px;
        }
        .search-section .search-title i {
            color: #0d6efd;
        }
        
        .search-box {
            display: flex;
            gap: 8px;
            background: #ffffff;
            border-radius: 8px;
            padding: 4px;
            border: 1px solid #eef1f5;
            transition: all 0.3s ease;
        }
        .search-box:focus-within {
            border-color: #0d6efd;
            box-shadow: 0 0 0 3px rgba(13,110,253,0.08);
        }
        .search-box .search-input {
            flex: 1;
            border: none;
            background: transparent;
            padding: 8px 14px;
            font-size: 1rem;
            font-family: 'Cambria', Georgia, serif;
            outline: none;
            color: #1a1a2e;
        }
        .search-box .search-input::placeholder {
            color: #adb5bd;
        }
        .search-box .search-btn {
            padding: 8px 20px;
            border: none;
            background: linear-gradient(135deg, #0d6efd, #0a58ca);
            color: #fff;
            border-radius: 6px;
            font-weight: 600;
            font-size: 0.95rem;
            font-family: 'Cambria', Georgia, serif;
            transition: all 0.2s ease;
            cursor: pointer;
            white-space: nowrap;
        }
        .search-box .search-btn:hover {
            transform: translateY(-1px);
            box-shadow: 0 2px 10px rgba(13,110,253,0.2);
        }
        .search-box .search-btn i {
            margin-right: 6px;
        }
        
        .search-clear-btn {
            padding: 8px 14px;
            border: none;
            background: transparent;
            color: #6c757d;
            font-size: 0.95rem;
            font-family: 'Cambria', Georgia, serif;
            transition: all 0.2s ease;
            cursor: pointer;
            white-space: nowrap;
        }
        .search-clear-btn:hover {
            color: #dc3545;
        }
        
        /* Search Results */
        .search-results {
            margin-top: 16px;
            padding-top: 14px;
            border-top: 1px solid #eef1f5;
        }
        .search-results .result-count {
            font-size: 0.95rem;
            color: #6c757d;
            margin-bottom: 10px;
            font-family: 'Cambria', Georgia, serif;
        }
        .search-results .result-count strong {
            color: #1a1a2e;
        }
        
        .search-result-item {
            background: #f8f9fa;
            border-radius: 6px;
            padding: 10px 14px;
            margin-bottom: 6px;
            border-left: 3px solid #0d6efd;
            transition: all 0.2s ease;
            display: flex;
            align-items: center;
            justify-content: space-between;
            flex-wrap: wrap;
            gap: 8px;
        }
        .search-result-item:hover {
            background: #f0f4f8;
        }
        .search-result-item .result-info {
            flex: 1;
        }
        .search-result-item .result-info h6 {
            font-weight: 600;
            font-size: 0.95rem;
            margin-bottom: 1px;
            font-family: 'Cambria', Georgia, serif;
        }
        .search-result-item .result-info .result-meta {
            font-size: 0.8rem;
            color: #6c757d;
        }
        .search-result-item .result-info .result-meta .badge-type {
            padding: 1px 8px;
            border-radius: 10px;
            font-size: 0.7rem;
            font-weight: 600;
        }
        .search-result-item .result-actions .btn {
            font-size: 0.8rem;
            padding: 3px 10px;
            border-radius: 4px;
            font-weight: 600;
            font-family: 'Cambria', Georgia, serif;
        }
        
        .search-no-results {
            text-align: center;
            padding: 30px 20px;
        }
        .search-no-results .icon {
            font-size: 2.5rem;
            color: #dee2e6;
            margin-bottom: 10px;
        }
        .search-no-results h5 {
            font-weight: 700;
            color: #1a1a2e;
            font-family: 'Cambria', Georgia, serif;
            font-size: 1.1rem;
        }
        .search-no-results p {
            color: #6c757d;
            font-family: 'Cambria', Georgia, serif;
            font-size: 0.95rem;
        }
        .search-no-results .suggestions {
            margin-top: 10px;
        }
        .search-no-results .suggestions .btn {
            font-family: 'Cambria', Georgia, serif;
            margin: 2px;
            font-size: 0.9rem;
            padding: 4px 14px;
        }
        
        /* ============================================
           FULL WIDTH - BOOKS & JOURNALS
           ============================================ */
        .full-width-section {
            margin-top: 25px;
            padding-top: 20px;
            border-top: 1px solid #eef1f5;
        }
        
        .section-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 12px;
        }
        .section-header h4 {
            font-weight: 700;
            font-size: 1.3rem;
            color: #1a1a2e;
            margin: 0;
            font-family: 'Cambria', Georgia, serif;
        }
        .section-header h4 i { margin-right: 8px; }
        .section-header a {
            font-size: 0.95rem;
            color: #0d6efd;
            text-decoration: none;
            font-weight: 500;
            font-family: 'Cambria', Georgia, serif;
        }
        .section-header a:hover { text-decoration: underline; }
        
        .items-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(200px, 1fr));
            gap: 16px;
        }
        
        /* Book Card - Compact */
        .item-card {
            background: #ffffff;
            border-radius: 8px;
            overflow: hidden;
            border: 1px solid #eef1f5;
            transition: all 0.2s ease;
            box-shadow: 0 1px 3px rgba(0,0,0,0.02);
            height: 100%;
            display: flex;
            flex-direction: column;
        }
        .item-card:hover {
            transform: translateY(-3px);
            box-shadow: 0 4px 15px rgba(0,0,0,0.04);
            border-color: #0d6efd;
        }
        
        .item-card .cover {
            height: 180px;
            background: #f8f9fa;
            display: flex;
            align-items: center;
            justify-content: center;
            overflow: hidden;
            position: relative;
            padding: 8px;
            flex-shrink: 0;
        }
        .item-card .cover img {
            max-height: 100%;
            width: auto;
            object-fit: contain;
        }
        .item-card .cover .placeholder {
            font-size: 2.8rem;
            color: #ced4da;
        }
        .item-card .cover .specialty-tag {
            position: absolute;
            top: 6px;
            right: 6px;
            background: rgba(0,0,0,0.6);
            color: #fff;
            font-size: 0.6rem;
            padding: 1px 8px;
            border-radius: 10px;
            font-weight: 500;
            font-family: 'Cambria', Georgia, serif;
        }
        
        .item-card .info {
            padding: 10px 12px 6px;
            flex: 1;
        }
        .item-card .info h6 {
            font-size: 0.95rem;
            font-weight: 700;
            margin-bottom: 2px;
            display: -webkit-box;
            -webkit-line-clamp: 2;
            -webkit-box-orient: vertical;
            overflow: hidden;
            line-height: 1.3;
            font-family: 'Cambria', Georgia, serif;
            color: #1a1a2e;
        }
        .item-card .info .author {
            font-size: 0.8rem;
            color: #6c757d;
            font-family: 'Cambria', Georgia, serif;
        }
        .item-card .info .meta {
            font-size: 0.7rem;
            color: #adb5bd;
            display: flex;
            gap: 4px;
            margin-top: 2px;
            flex-wrap: wrap;
        }
        .item-card .info .meta span {
            background: #f0f4f8;
            padding: 1px 8px;
            border-radius: 8px;
            font-family: 'Cambria', Georgia, serif;
        }
        
        .item-card .actions {
            padding: 4px 12px 10px;
            display: flex;
            gap: 4px;
            flex-shrink: 0;
        }
        .item-card .actions .btn {
            flex: 1;
            font-size: 0.75rem;
            padding: 4px 8px;
            border-radius: 4px;
            font-weight: 600;
            font-family: 'Cambria', Georgia, serif;
        }
        
        /* Journal Card */
        .item-card.journal .cover {
            height: 140px;
            background: linear-gradient(135deg, #f8f9fa, #eef1f5);
        }
        .item-card.journal .cover .journal-icon {
            font-size: 2.2rem;
            color: #198754;
        }
        .item-card.journal .cover .journal-name-tag {
            position: absolute;
            bottom: 6px;
            left: 50%;
            transform: translateX(-50%);
            background: rgba(0,0,0,0.7);
            color: #fff;
            font-size: 0.6rem;
            padding: 1px 10px;
            border-radius: 10px;
            font-weight: 500;
            white-space: nowrap;
            max-width: 90%;
            overflow: hidden;
            text-overflow: ellipsis;
            font-family: 'Cambria', Georgia, serif;
        }
        .item-card.journal:hover { border-color: #198754; }
        
        .item-card.journal .actions .btn {
            width: 100%;
            flex: none;
        }
        
        /* Empty State */
        .empty-state {
            text-align: center;
            padding: 40px 20px;
            width: 100%;
        }
        .empty-state .icon {
            font-size: 2.5rem;
            color: #dee2e6;
            margin-bottom: 10px;
        }
        .empty-state h5 {
            font-weight: 700;
            color: #1a1a2e;
            font-family: 'Cambria', Georgia, serif;
            font-size: 1.1rem;
        }
        .empty-state p {
            color: #6c757d;
            font-family: 'Cambria', Georgia, serif;
            font-size: 0.95rem;
        }
        
        /* ============================================
           RESPONSIVE
           ============================================ */
        @media (max-width: 992px) {
            .categories-sidebar {
                position: relative;
                top: 0;
                margin-bottom: 16px;
            }
            .right-content { padding-left: 0; }
            .items-grid { grid-template-columns: repeat(auto-fill, minmax(170px, 1fr)); }
            .search-box {
                flex-wrap: wrap;
                border-radius: 8px;
            }
            .search-box .search-input {
                flex: 1 1 100%;
                padding: 8px 12px;
            }
            .search-box .search-btn {
                flex: 1;
                padding: 6px 14px;
                border-radius: 4px;
            }
            .search-clear-btn {
                flex: 0 1 auto;
            }
            .brand-card .logo-image {
                height: 95px;
            }
        }
        
        @media (max-width: 768px) {
            .stats-grid { grid-template-columns: repeat(3, 1fr); gap: 8px; }
            .stat-card .number { font-size: 1.6rem; }
            .stat-card { padding: 12px 8px; }
            .items-grid { grid-template-columns: repeat(auto-fill, minmax(160px, 1fr)); gap: 10px; }
            .item-card .cover { height: 140px; }
            .item-card.journal .cover { height: 110px; }
            .brand-card .logo { font-size: 1.6rem; }
            .brand-card .logo i { font-size: 1.9rem; }
            .brand-card { padding: 14px 16px; }
            .brand-card .logo-image { height: 80px; }
            .search-section { margin-top: 14px; }
            .search-result-item { flex-direction: column; align-items: flex-start; }
            .search-result-item .result-actions { width: 100%; }
            .search-result-item .result-actions .btn { width: 100%; }
        }
        
        /* ============================================
           MOBILE VERSION (≤576px)
           Brand Card FIRST, Categories SECOND
           ============================================ */
        @media (max-width: 576px) {
            /* Reorder columns: Brand Card first, Categories second */
            .row.g-3 {
                display: flex;
                flex-direction: column;
            }
            
            .col-lg-8 {
                order: 1;  /* Brand Card - FIRST */
                width: 100%;
                flex: 0 0 100%;
                max-width: 100%;
                padding: 0;
            }
            
            .col-lg-4 {
                order: 2;  /* Categories - SECOND */
                width: 100%;
                flex: 0 0 100%;
                max-width: 100%;
                padding: 0;
            }
            
            .stats-grid { grid-template-columns: repeat(3, 1fr); gap: 4px; }
            .stat-card .number { font-size: 1.3rem; }
            .stat-card .label { font-size: 0.7rem; }
            .stat-card .icon { font-size: 1.4rem; }
            .stat-card { padding: 8px 4px; }
            .items-grid { grid-template-columns: repeat(2, 1fr); gap: 8px; }
            .item-card .cover { height: 120px; }
            .item-card.journal .cover { height: 95px; }
            .item-card .info h6 { font-size: 0.85rem; }
            .item-card .actions .btn { font-size: 0.65rem; padding: 2px 4px; }
            .brand-card .logo { font-size: 1.3rem; }
            .brand-card .logo i { font-size: 1.4rem; }
            .brand-card { 
                padding: 10px 12px;
                margin-top: 0;
                margin-bottom: 12px;
            }
            .brand-card .tagline { font-size: 0.85rem; }
            .brand-card .logo-image { height: 75px; }
            .categories-sidebar { 
                padding: 12px 10px; 
                margin-bottom: 0;
            }
            .category-item { padding: 4px 0; font-size: 0.9rem; }
            .category-item .name { font-size: 0.88rem; }
            .section-header h4 { font-size: 1.05rem; }
            .search-section .search-title { font-size: 0.95rem; }
            .search-box { border-radius: 6px; padding: 3px; }
            .search-box .search-input { font-size: 0.9rem; padding: 6px 10px; }
            .search-box .search-btn { font-size: 0.85rem; padding: 4px 10px; }
            .search-clear-btn { font-size: 0.85rem; padding: 4px 8px; }
            .search-result-item { padding: 8px 10px; }
            .search-result-item .result-info h6 { font-size: 0.9rem; }
            
            .main-wrapper {
                padding: 15px 0 10px;
            }
            
            .container {
                padding-left: 10px;
                padding-right: 10px;
            }
        }
        
        @media (max-width: 400px) {
            .items-grid { grid-template-columns: repeat(2, 1fr); gap: 6px; }
            .item-card .cover { height: 100px; }
            .item-card.journal .cover { height: 80px; }
            .item-card .info h6 { font-size: 0.8rem; }
            .item-card .info .author { font-size: 0.7rem; }
            .item-card .info .meta span { font-size: 0.6rem; padding: 0 6px; }
            .item-card .actions .btn { 
                font-size: 0.6rem; 
                padding: 1px 3px;
            }
            .brand-card .logo-image { height: 70px; }
        }
    </style>
</head>
<body>
    <!-- ============================================
    NAVIGATION - Including public_nav.php
    ============================================ -->
    <?php include __DIR__ . '/../includes/public_nav.php'; ?>

    <!-- ============================================
    MAIN CONTENT - TWO COLUMN + SEARCH + FULL WIDTH
    ============================================ -->
    <div class="main-wrapper">
        <div class="container">
            
            <!-- TWO COLUMN SECTION -->
            <div class="row g-3">
                
                <!-- ============================================
                COLUMN 1 - BRAND CARD + STATISTICS (ON MOBILE: SHOWS FIRST)
                ============================================ -->
                <div class="col-lg-8 right-content">
                    
                    <!-- BRAND CARD -->
                    <div class="brand-card">
                        <div class="logo">
                            <img src="/assets/images/logo.png" alt="UCLP Academy" class="logo-image">
                        </div>
                    </div>
                    
                    <!-- STATISTICS CARDS -->
                    <div class="stats-grid">
                        <div class="stat-card">
                            <div class="icon blue"><i class="fas fa-book"></i></div>
                            <div class="number"><?php echo number_format($stats['books']); ?></div>
                            <div class="label">Books Available</div>
                        </div>
                        <div class="stat-card">
                            <div class="icon green"><i class="fas fa-newspaper"></i></div>
                            <div class="number"><?php echo number_format($stats['journals']); ?></div>
                            <div class="label">Journals Available</div>
                        </div>
                        <div class="stat-card">
                            <div class="icon purple"><i class="fas fa-list-ul"></i></div>
                            <div class="number"><?php echo number_format($stats['specialties']); ?></div>
                            <div class="label">Categories</div>
                        </div>
                    </div>
                    
                </div>
                
                <!-- ============================================
                COLUMN 2 - CATEGORIES (ON MOBILE: SHOWS SECOND)
                Sorted by Highest to Lowest Total Items
                ============================================ -->
                <div class="col-lg-4">
                    <div class="categories-sidebar">
                        <div class="header">
                            <i class="fas fa-list-ul"></i> Categories
                        </div>
                        
                        <?php if (empty($displaySpecialties)): ?>
                            <div class="text-muted text-center py-2" style="font-size: 0.9rem; font-family: 'Cambria', Georgia, serif;">
                                <i class="fas fa-inbox fa-2x d-block mb-1" style="color: #dee2e6;"></i>
                                No categories available
                            </div>
                        <?php else: ?>
                            <?php foreach ($displaySpecialties as $specialty): 
                                $totalItems = $specialty['book_count'] + $specialty['journal_count'];
                            ?>
                            <a href="/browse/<?php echo $specialty['id']; ?>" class="category-item">
                                <span class="name"><?php echo htmlspecialchars($specialty['name']); ?></span>
                                <span class="badge-count"><?php echo $totalItems; ?></span>
                            </a>
                            <?php endforeach; ?>
                        <?php endif; ?>
                        
                        <div class="view-all-categories">
                            <a href="/browse" class="btn btn-outline-primary btn-sm">
                                <i class="fas fa-arrow-right"></i> View All Categories
                            </a>
                        </div>
                    </div>
                </div>
            </div>
            
            <!-- ============================================
            SEARCH SECTION - FULL WIDTH
            ============================================ -->
            <div class="search-section">
                <div class="search-wrapper">
                    <div class="search-title">
                        <i class="fas fa-search"></i> Search Medical Resources
                    </div>
                    
                    <form method="GET" action="/" class="search-box">
                        <input type="text" class="search-input" name="search" 
                               placeholder="Search for books, journals, authors, or topics..." 
                               value="<?php echo htmlspecialchars($searchQuery); ?>"
                               autocomplete="off">
                        <?php if (!empty($searchQuery)): ?>
                        <a href="/" class="search-clear-btn" title="Clear search">
                            <i class="fas fa-times"></i> Clear
                        </a>
                        <?php endif; ?>
                        <button type="submit" class="search-btn">
                            <i class="fas fa-search"></i> Search
                        </button>
                    </form>
                    
                    <!-- SEARCH RESULTS -->
                    <?php if ($searchPerformed): ?>
                    <div class="search-results">
                        <?php if (!empty($searchResults)): ?>
                            <div class="result-count">
                                Found <strong><?php echo count($searchResults); ?></strong> result(s) for "<strong><?php echo htmlspecialchars($searchQuery); ?></strong>"
                            </div>
                            
                            <?php foreach ($searchResults as $result): ?>
                            <div class="search-result-item">
                                <div class="result-info">
                                    <h6>
                                        <?php if ($result['item_type'] == 'book'): ?>
                                            <i class="fas fa-book text-primary"></i>
                                        <?php else: ?>
                                            <i class="fas fa-newspaper text-success"></i>
                                        <?php endif; ?>
                                        <?php echo htmlspecialchars($result['title']); ?>
                                    </h6>
                                    <div class="result-meta">
                                        <?php if ($result['item_type'] == 'book'): ?>
                                            <span class="badge-type book">Book</span>
                                            <?php echo htmlspecialchars($result['author']); ?>
                                            <?php if (!empty($result['year'])): ?>
                                                &bull; <?php echo $result['year']; ?>
                                            <?php endif; ?>
                                        <?php else: ?>
                                            <span class="badge-type journal">Journal</span>
                                            <?php echo htmlspecialchars($result['journal_name']); ?>
                                            <?php if (!empty($result['date'])): ?>
                                                &bull; <?php echo date('M Y', strtotime($result['date'])); ?>
                                            <?php endif; ?>
                                        <?php endif; ?>
                                        &bull; <span class="text-muted"><?php echo htmlspecialchars($result['specialty_name']); ?></span>
                                    </div>
                                </div>
                                <div class="result-actions">
                                    <?php if (isAuthenticated()): ?>
                                        <?php if ($result['item_type'] == 'book'): ?>
                                            <a href="/doctor/view-book/<?php echo $result['id']; ?>" class="btn btn-primary btn-sm">
                                                <i class="fas fa-eye"></i> View
                                            </a>
                                            <a href="/doctor/read/<?php echo $result['id']; ?>" class="btn btn-outline-primary btn-sm">
                                                <i class="fas fa-book-open"></i> Read
                                            </a>
                                        <?php else: ?>
                                            <a href="/doctor/view-journal/<?php echo $result['id']; ?>" class="btn btn-success btn-sm">
                                                <i class="fas fa-eye"></i> View Journal
                                            </a>
                                        <?php endif; ?>
                                    <?php else: ?>
                                        <a href="/login" class="btn btn-primary btn-sm">
                                            <i class="fas fa-lock"></i> Login to View
                                        </a>
                                    <?php endif; ?>
                                </div>
                            </div>
                            <?php endforeach; ?>
                            
                        <?php else: ?>
                            <div class="search-no-results">
                                <div class="icon"><i class="fas fa-search"></i></div>
                                <h5>No results found</h5>
                                <p>We couldn't find any matches for "<strong><?php echo htmlspecialchars($searchQuery); ?></strong>"</p>
                                <div class="suggestions">
                                    <span class="text-muted">Try:</span>
                                    <a href="/" class="btn btn-outline-secondary btn-sm">Clear Search</a>
                                    <a href="/browse" class="btn btn-outline-primary btn-sm">Browse All Resources</a>
                                </div>
                            </div>
                        <?php endif; ?>
                    </div>
                    <?php endif; ?>
                </div>
            </div>
            
            <!-- ============================================
            FULL WIDTH SECTION - BOOKS & JOURNALS
            ============================================ -->
            <div class="full-width-section">
                
                <!-- ============================================
                LATEST BOOKS - 6 ITEMS
                ============================================ -->
                <div class="section-header">
                    <h4><i class="fas fa-book text-primary"></i> Latest Books</h4>
                    <a href="/browse" class="view-all">View All <i class="fas fa-arrow-right"></i></a>
                </div>
                
                <?php if (empty($latestBooks)): ?>
                    <div class="empty-state">
                        <div class="icon"><i class="fas fa-book"></i></div>
                        <h5>No Books Available</h5>
                        <p>No books are available at the moment.</p>
                    </div>
                <?php else: ?>
                <div class="items-grid">
                    <?php foreach ($latestBooks as $book): ?>
                    <div class="item-card">
                        <div class="cover">
                            <?php if ($book['cover_image']): ?>
                            <img src="/uploads/books/<?php echo $book['cover_image']; ?>" 
                                 alt="<?php echo htmlspecialchars($book['title']); ?>" loading="lazy">
                            <?php else: ?>
                            <div class="placeholder"><i class="fas fa-book"></i></div>
                            <?php endif; ?>
                            <span class="specialty-tag"><?php echo htmlspecialchars($book['specialty_name']); ?></span>
                        </div>
                        <div class="info">
                            <h6><?php echo htmlspecialchars($book['title']); ?></h6>
                            <div class="author"><?php echo htmlspecialchars($book['author']); ?></div>
                            <div class="meta">
                                <span><?php echo $book['year'] ?? 'N/A'; ?></span>
                            </div>
                        </div>
                        <div class="actions">
                            <?php if (isAuthenticated()): ?>
                            <a href="/doctor/view-book/<?php echo $book['id']; ?>" class="btn btn-primary btn-sm">
                                <i class="fas fa-eye"></i> View
                            </a>
                            <a href="/doctor/read/<?php echo $book['id']; ?>" class="btn btn-outline-primary btn-sm">
                                <i class="fas fa-book-open"></i> Read
                            </a>
                            <?php else: ?>
                            <a href="/login" class="btn btn-primary btn-sm">
                                <i class="fas fa-lock"></i> Login to View
                            </a>
                            <?php endif; ?>
                        </div>
                    </div>
                    <?php endforeach; ?>
                </div>
                <?php endif; ?>
                
                <!-- ============================================
                LATEST JOURNALS - 6 ITEMS
                ============================================ -->
                <div class="section-header" style="margin-top: 30px;">
                    <h4><i class="fas fa-newspaper text-success"></i> Latest Journals</h4>
                    <a href="/browse" class="view-all">View All <i class="fas fa-arrow-right"></i></a>
                </div>
                
                <?php if (empty($latestJournals)): ?>
                    <div class="empty-state">
                        <div class="icon"><i class="fas fa-newspaper"></i></div>
                        <h5>No Journals Available</h5>
                        <p>No journals are available at the moment.</p>
                    </div>
                <?php else: ?>
                <div class="items-grid">
                    <?php foreach ($latestJournals as $journal): ?>
                    <div class="item-card journal">
                        <div class="cover">
                            <div class="journal-icon"><i class="fas fa-file-alt"></i></div>
                            <span class="specialty-tag"><?php echo htmlspecialchars($journal['specialty_name']); ?></span>
                            <span class="journal-name-tag"><?php echo htmlspecialchars($journal['journal_name']); ?></span>
                        </div>
                        <div class="info">
                            <h6><?php echo htmlspecialchars($journal['title']); ?></h6>
                            <div class="meta">
                                <?php if ($journal['date']): ?>
                                <span><i class="far fa-calendar-alt"></i> <?php echo date('M Y', strtotime($journal['date'])); ?></span>
                                <?php endif; ?>
                                <?php if ($journal['volume']): ?>
                                <span>Vol <?php echo $journal['volume']; ?></span>
                                <?php endif; ?>
                            </div>
                        </div>
                        <div class="actions">
                            <?php if (isAuthenticated()): ?>
                            <a href="/doctor/view-journal/<?php echo $journal['id']; ?>" class="btn btn-success btn-sm w-100">
                                <i class="fas fa-eye"></i> View Journal
                            </a>
                            <?php else: ?>
                            <a href="/login" class="btn btn-success btn-sm w-100">
                                <i class="fas fa-lock"></i> Login to View
                            </a>
                            <?php endif; ?>
                        </div>
                    </div>
                    <?php endforeach; ?>
                </div>
                <?php endif; ?>
                
            </div>
        </div>
    </div>

    <!-- ============================================
    FOOTER
    ============================================ -->
    <footer class="footer-main" style="background: #ffffff; padding: 14px 0; border-top: 1px solid #eef1f5; margin-top: 10px;">
        <div class="container">
            <p style="margin: 0; color: #1a1a2e; font-size: 0.9rem; text-align: center; font-family: 'Cambria', Georgia, serif;">
                <strong style="color: #0d6efd;">UCLP Academy</strong> &copy; <?php echo date('Y'); ?> 
                <span style="color: #6c757d;">v2.0</span> &bull; 
                <span style="color: #6c757d;">Powered by UniMed UniHealth Group</span>
            </p>
        </div>
    </footer>

    <script>
        // Auto-submit search on Enter key
        document.addEventListener('DOMContentLoaded', function() {
            const searchInput = document.querySelector('.search-input');
            if (searchInput) {
                searchInput.addEventListener('keypress', function(e) {
                    if (e.key === 'Enter') {
                        e.preventDefault();
                        this.form.submit();
                    }
                });
            }
        });
    </script>
</body>
</html>