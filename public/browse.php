<?php
require_once __DIR__ . '/../includes/config.php';
require_once __DIR__ . '/../includes/functions.php';
require_once __DIR__ . '/../includes/auth.php';

$specialtyId = isset($_GET['specialty']) ? intval($_GET['specialty']) : 0;
$searchQuery = isset($_GET['search']) ? sanitize($_GET['search']) : '';
$specialty = $specialtyId ? getSpecialtyById($specialtyId) : null;

$db = Database::getInstance()->getConnection();

// Get books and journals with search filter
$books = [];
$journals = [];

// Build search condition - using column names without table prefix in the condition
if (!empty($searchQuery)) {
    $searchTerm = '%' . $searchQuery . '%';
}

if ($specialtyId && $specialty) {
    // Get books by specialty with search
    if (!empty($searchQuery)) {
        $bookStmt = $db->prepare("
            SELECT b.*, s.name as specialty_name 
            FROM books b 
            JOIN specialties s ON b.specialty_id = s.id 
            WHERE b.specialty_id = ? AND b.status = 'approved' 
            AND (b.title LIKE ? OR b.author LIKE ? OR b.description LIKE ? OR b.publisher LIKE ? OR b.isbn LIKE ?)
            ORDER BY b.title
        ");
        $bookStmt->bind_param("isssss", $specialtyId, $searchTerm, $searchTerm, $searchTerm, $searchTerm, $searchTerm);
    } else {
        $bookStmt = $db->prepare("
            SELECT b.*, s.name as specialty_name 
            FROM books b 
            JOIN specialties s ON b.specialty_id = s.id 
            WHERE b.specialty_id = ? AND b.status = 'approved' 
            ORDER BY b.title
        ");
        $bookStmt->bind_param("i", $specialtyId);
    }
    $bookStmt->execute();
    $books = $bookStmt->get_result()->fetch_all(MYSQLI_ASSOC);
    $bookStmt->close();
    
    // Get journals by specialty with search
    if (!empty($searchQuery)) {
        $journalStmt = $db->prepare("
            SELECT j.*, s.name as specialty_name 
            FROM journals j 
            JOIN specialties s ON j.specialty_id = s.id 
            WHERE j.specialty_id = ? AND j.status = 'approved' 
            AND (j.title LIKE ? OR j.journal_name LIKE ? OR j.abstract LIKE ? OR j.doi LIKE ?)
            ORDER BY j.date DESC
        ");
        $journalStmt->bind_param("issss", $specialtyId, $searchTerm, $searchTerm, $searchTerm, $searchTerm);
    } else {
        $journalStmt = $db->prepare("
            SELECT j.*, s.name as specialty_name 
            FROM journals j 
            JOIN specialties s ON j.specialty_id = s.id 
            WHERE j.specialty_id = ? AND j.status = 'approved' 
            ORDER BY j.date DESC
        ");
        $journalStmt->bind_param("i", $specialtyId);
    }
    $journalStmt->execute();
    $journals = $journalStmt->get_result()->fetch_all(MYSQLI_ASSOC);
    $journalStmt->close();
} else {
    // Get all approved books and journals with search
    if (!empty($searchQuery)) {
        $bookStmt = $db->prepare("
            SELECT b.*, s.name as specialty_name 
            FROM books b 
            JOIN specialties s ON b.specialty_id = s.id 
            WHERE b.status = 'approved' 
            AND (b.title LIKE ? OR b.author LIKE ? OR b.description LIKE ? OR b.publisher LIKE ? OR b.isbn LIKE ?)
            ORDER BY b.title
        ");
        $bookStmt->bind_param("sssss", $searchTerm, $searchTerm, $searchTerm, $searchTerm, $searchTerm);
    } else {
        $bookStmt = $db->prepare("
            SELECT b.*, s.name as specialty_name 
            FROM books b 
            JOIN specialties s ON b.specialty_id = s.id 
            WHERE b.status = 'approved' 
            ORDER BY b.title
        ");
    }
    $bookStmt->execute();
    $books = $bookStmt->get_result()->fetch_all(MYSQLI_ASSOC);
    $bookStmt->close();
    
    // Get all approved journals with search
    if (!empty($searchQuery)) {
        $journalStmt = $db->prepare("
            SELECT j.*, s.name as specialty_name 
            FROM journals j 
            JOIN specialties s ON j.specialty_id = s.id 
            WHERE j.status = 'approved' 
            AND (j.title LIKE ? OR j.journal_name LIKE ? OR j.abstract LIKE ? OR j.doi LIKE ?)
            ORDER BY j.date DESC
        ");
        $journalStmt->bind_param("ssss", $searchTerm, $searchTerm, $searchTerm, $searchTerm);
    } else {
        $journalStmt = $db->prepare("
            SELECT j.*, s.name as specialty_name 
            FROM journals j 
            JOIN specialties s ON j.specialty_id = s.id 
            WHERE j.status = 'approved' 
            ORDER BY j.date DESC
        ");
    }
    $journalStmt->execute();
    $journals = $journalStmt->get_result()->fetch_all(MYSQLI_ASSOC);
    $journalStmt->close();
}

// Get all specialties for filter (only those with content)
$allSpecialties = $db->query("
    SELECT DISTINCT s.*, 
        (SELECT COUNT(*) FROM books WHERE specialty_id = s.id AND status = 'approved') as book_count,
        (SELECT COUNT(*) FROM journals WHERE specialty_id = s.id AND status = 'approved') as journal_count
    FROM specialties s
    WHERE s.status = 1
    AND (
        EXISTS (SELECT 1 FROM books WHERE specialty_id = s.id AND status = 'approved')
        OR EXISTS (SELECT 1 FROM journals WHERE specialty_id = s.id AND status = 'approved')
    )
    ORDER BY s.name
")->fetch_all(MYSQLI_ASSOC);

// Get statistics
$stats = [
    'books' => $db->query("SELECT COUNT(*) as count FROM books WHERE status = 'approved'")->fetch_assoc()['count'],
    'journals' => $db->query("SELECT COUNT(*) as count FROM journals WHERE status = 'approved'")->fetch_assoc()['count'],
    'specialties' => count($allSpecialties),
];
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><?php echo $specialty ? htmlspecialchars($specialty['name']) : 'Browse'; ?> - UCLP Academy</title>
    
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
            font-size: 16px;
        }
        
        /* ============================================
           PAGE HEADER
           ============================================ */
        .page-header {
            background: #ffffff;
            padding: 24px 0 28px;
            border-bottom: 1px solid #eef1f5;
            margin-bottom: 0;
        }
        .page-header h1 {
            font-weight: 700;
            font-size: 1.8rem;
            font-family: 'Cambria', Georgia, serif;
            color: #1a1a2e;
            margin: 0;
        }
        .page-header .subtitle {
            color: #6c757d;
            font-size: 1rem;
            font-family: 'Cambria', Georgia, serif;
            margin: 6px 0 0;
        }
        .page-header .stats-badge {
            display: flex;
            gap: 12px;
            flex-wrap: wrap;
            margin-top: 10px;
        }
        .page-header .stats-badge .badge {
            padding: 8px 18px;
            font-size: 0.85rem;
            font-weight: 600;
            font-family: 'Cambria', Georgia, serif;
            border-radius: 20px;
        }
        
        /* ============================================
           SEARCH SECTION
           ============================================ */
        .search-section {
            background: #ffffff;
            padding: 20px 0;
            border-bottom: 1px solid #eef1f5;
        }
        .search-section .search-wrapper {
            max-width: 100%;
            margin: 0 auto;
        }
        .search-section .search-box {
            display: flex;
            gap: 10px;
            background: #f8f9fa;
            border-radius: 10px;
            padding: 5px;
            border: 2px solid #eef1f5;
            transition: all 0.3s ease;
        }
        .search-section .search-box:focus-within {
            border-color: #0d6efd;
            box-shadow: 0 0 0 4px rgba(13,110,253,0.08);
        }
        .search-section .search-box .search-input {
            flex: 1;
            border: none;
            background: transparent;
            padding: 10px 18px;
            font-size: 1rem;
            font-family: 'Cambria', Georgia, serif;
            outline: none;
            color: #1a1a2e;
        }
        .search-section .search-box .search-input::placeholder {
            color: #adb5bd;
        }
        .search-section .search-box .search-btn {
            padding: 10px 24px;
            border: none;
            background: linear-gradient(135deg, #0d6efd, #0a58ca);
            color: #fff;
            border-radius: 8px;
            font-weight: 600;
            font-size: 0.95rem;
            font-family: 'Cambria', Georgia, serif;
            transition: all 0.2s ease;
            cursor: pointer;
            white-space: nowrap;
        }
        .search-section .search-box .search-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 15px rgba(13,110,253,0.25);
        }
        .search-section .search-box .search-btn i {
            margin-right: 8px;
        }
        .search-section .search-box .search-clear-btn {
            padding: 10px 16px;
            border: none;
            background: transparent;
            color: #6c757d;
            font-size: 0.95rem;
            font-family: 'Cambria', Georgia, serif;
            transition: all 0.2s ease;
            cursor: pointer;
            white-space: nowrap;
            text-decoration: none;
        }
        .search-section .search-box .search-clear-btn:hover {
            color: #dc3545;
        }
        .search-section .search-results-info {
            margin-top: 12px;
            font-size: 0.95rem;
            color: #6c757d;
            font-family: 'Cambria', Georgia, serif;
        }
        .search-section .search-results-info strong {
            color: #1a1a2e;
        }
        
        /* ============================================
           MAIN LAYOUT
           ============================================ */
        .main-wrapper {
            padding: 28px 0 10px;
            min-height: calc(100vh - 200px);
        }
        
        /* ============================================
           FILTER SIDEBAR - CATEGORIES LIST
           ============================================ */
        .filter-sidebar {
            background: #ffffff;
            border-radius: 10px;
            border: 1px solid #eef1f5;
            padding: 20px 18px;
            position: sticky;
            top: 80px;
            box-shadow: 0 1px 3px rgba(0,0,0,0.02);
        }
        .filter-sidebar .header {
            font-weight: 700;
            font-size: 1.1rem;
            color: #1a1a2e;
            padding-bottom: 14px;
            border-bottom: 1px solid #eef1f5;
            margin-bottom: 12px;
            font-family: 'Cambria', Georgia, serif;
        }
        .filter-sidebar .header i { 
            color: #0d6efd; 
            margin-right: 10px;
        }
        
        .filter-item {
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 8px 0;
            text-decoration: none;
            color: #4a4a5e;
            font-family: 'Cambria', Georgia, serif;
            cursor: pointer;
            font-size: 1rem;
            border-bottom: 1px solid #f5f7fa;
        }
        .filter-item:last-of-type {
            border-bottom: none;
        }
        .filter-item:hover {
            color: #0d6efd;
        }
        .filter-item .name {
            font-size: 0.95rem;
            font-weight: 500;
        }
        .filter-item .badge-count {
            font-size: 0.7rem;
            background: #e9ecef;
            padding: 2px 10px;
            border-radius: 12px;
            color: #6c757d;
            min-width: 24px;
            text-align: center;
        }
        .filter-item:hover .badge-count {
            background: #d4e2fc;
            color: #0d6efd;
        }
        .filter-item.active {
            color: #0d6efd;
            font-weight: 600;
        }
        .filter-item.active .badge-count {
            background: #0d6efd;
            color: #fff;
        }
        
        .filter-divider {
            height: 1px;
            background: #eef1f5;
            margin: 12px 0;
        }
        
        .back-home-btn {
            margin-top: 12px;
            padding-top: 12px;
            border-top: 1px solid #eef1f5;
        }
        .back-home-btn .btn {
            font-family: 'Cambria', Georgia, serif;
            font-weight: 600;
            border-radius: 6px;
            padding: 6px 12px;
            font-size: 0.9rem;
            width: 100%;
        }
        
        /* ============================================
           CONTENT AREA
           ============================================ */
        .content-area {
            padding-left: 0;
        }
        
        .section-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin: 0 0 16px;
        }
        .section-header h4 {
            font-weight: 700;
            font-size: 1.2rem;
            color: #1a1a2e;
            margin: 0;
            font-family: 'Cambria', Georgia, serif;
        }
        .section-header h4 i { margin-right: 10px; }
        .section-header .count {
            font-size: 0.9rem;
            color: #6c757d;
            font-family: 'Cambria', Georgia, serif;
        }
        
        .items-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(200px, 1fr));
            gap: 16px;
        }
        
        /* Book Card - Same as index.php */
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
            height: 200px;
            background: #f8f9fa;
            display: flex;
            align-items: center;
            justify-content: center;
            overflow: hidden;
            position: relative;
            padding: 10px;
            flex-shrink: 0;
        }
        .item-card .cover img {
            max-height: 100%;
            width: auto;
            object-fit: contain;
        }
        .item-card .cover .placeholder {
            font-size: 3rem;
            color: #ced4da;
        }
        .item-card .cover .specialty-tag {
            position: absolute;
            top: 8px;
            right: 8px;
            background: rgba(0,0,0,0.6);
            color: #fff;
            font-size: 0.6rem;
            padding: 2px 10px;
            border-radius: 12px;
            font-weight: 500;
            font-family: 'Cambria', Georgia, serif;
        }
        
        .item-card .info {
            padding: 12px 14px 8px;
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
            font-size: 0.85rem;
            color: #6c757d;
            font-family: 'Cambria', Georgia, serif;
        }
        .item-card .info .meta {
            font-size: 0.7rem;
            color: #adb5bd;
            display: flex;
            gap: 4px;
            margin-top: 4px;
            flex-wrap: wrap;
        }
        .item-card .info .meta span {
            background: #f0f4f8;
            padding: 1px 10px;
            border-radius: 10px;
            font-family: 'Cambria', Georgia, serif;
        }
        
        .item-card .actions {
            padding: 4px 14px 12px;
            display: flex;
            gap: 6px;
            flex-shrink: 0;
        }
        .item-card .actions .btn {
            flex: 1;
            font-size: 0.75rem;
            padding: 5px 10px;
            border-radius: 4px;
            font-weight: 600;
            font-family: 'Cambria', Georgia, serif;
        }
        
        /* Journal Card - Same as index.php */
        .item-card.journal .cover {
            height: 160px;
            background: linear-gradient(135deg, #f8f9fa, #eef1f5);
        }
        .item-card.journal .cover .journal-icon {
            font-size: 2.5rem;
            color: #198754;
        }
        .item-card.journal .cover .journal-name-tag {
            position: absolute;
            bottom: 8px;
            left: 50%;
            transform: translateX(-50%);
            background: rgba(0,0,0,0.7);
            color: #fff;
            font-size: 0.6rem;
            padding: 2px 12px;
            border-radius: 12px;
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
        }
        .empty-state .icon {
            font-size: 3rem;
            color: #dee2e6;
            margin-bottom: 12px;
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
        
        /* Tablet & Small Desktop */
        @media (max-width: 992px) {
            .filter-sidebar {
                position: relative;
                top: 0;
                margin-bottom: 18px;
            }
            .content-area { padding-left: 0; }
            .items-grid { grid-template-columns: repeat(auto-fill, minmax(180px, 1fr)); }
            .search-section .search-box {
                flex-wrap: wrap;
                border-radius: 10px;
            }
            .search-section .search-box .search-input {
                flex: 1 1 100%;
                padding: 10px 14px;
            }
            .search-section .search-box .search-btn {
                flex: 1;
                padding: 8px 16px;
                border-radius: 6px;
            }
            .search-section .search-box .search-clear-btn {
                flex: 0 1 auto;
            }
        }
        
        /* Mobile */
        @media (max-width: 768px) {
            .items-grid { grid-template-columns: repeat(auto-fill, minmax(170px, 1fr)); gap: 12px; }
            .item-card .cover { height: 160px; }
            .item-card.journal .cover { height: 130px; }
            .page-header h1 { font-size: 1.5rem; }
            .page-header { padding: 18px 0 20px; }
            .page-header .subtitle { font-size: 0.9rem; }
            .search-section { padding: 14px 0; }
            .search-section .search-box .search-input { font-size: 0.9rem; padding: 8px 12px; }
            .search-section .search-box .search-btn { font-size: 0.85rem; padding: 6px 14px; }
            .search-section .search-box .search-clear-btn { font-size: 0.85rem; padding: 6px 12px; }
        }
        
        /* Mobile Small */
        @media (max-width: 576px) {
            /* Reorder: Categories first on mobile */
            .row.g-4 {
                display: flex;
                flex-direction: column;
            }
            
            .col-lg-3 {
                order: 1;
                width: 100%;
                flex: 0 0 100%;
                max-width: 100%;
                padding: 0 12px;
            }
            
            .col-lg-9 {
                order: 2;
                width: 100%;
                flex: 0 0 100%;
                max-width: 100%;
                padding: 0 12px;
            }
            
            .items-grid { 
                grid-template-columns: repeat(2, 1fr); 
                gap: 10px; 
            }
            .item-card .cover { height: 130px; }
            .item-card.journal .cover { height: 105px; }
            .item-card .info h6 { font-size: 0.85rem; }
            .item-card .actions .btn { 
                font-size: 0.65rem; 
                padding: 3px 6px;
            }
            .item-card .info { padding: 8px 10px 4px; }
            .item-card .actions { padding: 2px 10px 10px; }
            
            .page-header { padding: 14px 0 18px; }
            .page-header h1 { font-size: 1.3rem; }
            .page-header .subtitle { font-size: 0.85rem; }
            .page-header .stats-badge .badge { 
                font-size: 0.7rem; 
                padding: 4px 12px;
            }
            
            .filter-sidebar { 
                padding: 14px 12px; 
                margin-bottom: 14px;
                border-radius: 8px;
            }
            .filter-item { 
                padding: 5px 0; 
                font-size: 0.9rem;
            }
            .filter-item .name { font-size: 0.88rem; }
            .section-header h4 { font-size: 1.05rem; }
            .section-header .count { font-size: 0.8rem; }
            
            .main-wrapper {
                padding: 14px 0 10px;
            }
            
            .container {
                padding-left: 10px;
                padding-right: 10px;
            }
            
            .search-section { padding: 12px 0; }
            .search-section .search-box { 
                border-radius: 8px; 
                padding: 4px;
                border-width: 2px;
            }
            .search-section .search-box .search-input { 
                font-size: 0.88rem; 
                padding: 8px 12px; 
            }
            .search-section .search-box .search-btn { 
                font-size: 0.82rem; 
                padding: 6px 12px; 
            }
            .search-section .search-box .search-clear-btn { 
                font-size: 0.82rem; 
                padding: 6px 10px; 
            }
            .search-section .search-results-info { 
                font-size: 0.85rem; 
                margin-top: 8px; 
            }
        }
        
        /* Extra Small */
        @media (max-width: 400px) {
            .items-grid { 
                grid-template-columns: repeat(2, 1fr); 
                gap: 8px; 
            }
            .item-card .cover { height: 110px; }
            .item-card.journal .cover { height: 90px; }
            .item-card .info h6 { font-size: 0.78rem; }
            .item-card .info .author { font-size: 0.7rem; }
            .item-card .info .meta span { font-size: 0.6rem; padding: 0 6px; }
            .item-card .actions .btn { 
                font-size: 0.55rem; 
                padding: 2px 4px;
            }
            .item-card .cover .specialty-tag { 
                font-size: 0.5rem; 
                padding: 1px 8px;
            }
            .item-card.journal .cover .journal-name-tag {
                font-size: 0.5rem;
                padding: 1px 8px;
            }
        }
        
        /* ============================================
           FOOTER
           ============================================ */
        .footer-main {
            background: #ffffff;
            padding: 16px 0;
            border-top: 1px solid #eef1f5;
            margin-top: 10px;
        }
        .footer-main p {
            margin: 0;
            color: #1a1a2e;
            font-size: 0.9rem;
            text-align: center;
            font-family: 'Cambria', Georgia, serif;
        }
        .footer-main p strong { color: #0d6efd; }
        .footer-main p .version { color: #6c757d; }
    </style>
</head>
<body>
    <!-- ============================================
    NAVIGATION - Using public_nav.php
    ============================================ -->
    <?php include __DIR__ . '/../includes/public_nav.php'; ?>

    <!-- ============================================
    PAGE HEADER
    ============================================ -->
    <div class="page-header">
        <div class="container">
            <div class="d-flex flex-wrap align-items-center justify-content-between">
                <div>
                    <h1>
                        <?php if ($specialty): ?>
                            <i class="fas fa-tag text-primary" style="font-size: 1.3rem;"></i>
                            <?php echo htmlspecialchars($specialty['name']); ?>
                        <?php else: ?>
                            <i class="fas fa-search text-primary" style="font-size: 1.3rem;"></i>
                            Browse Resources
                        <?php endif; ?>
                    </h1>
                    <div class="subtitle">
                        <?php if ($specialty && !empty($specialty['description'])): ?>
                            <?php echo htmlspecialchars($specialty['description']); ?>
                        <?php else: ?>
                            Explore our collection of medical books and journals
                        <?php endif; ?>
                    </div>
                </div>
                <div class="stats-badge">
                    <span class="badge bg-primary"><i class="fas fa-book"></i> <?php echo count($books); ?> Books</span>
                    <span class="badge bg-success"><i class="fas fa-newspaper"></i> <?php echo count($journals); ?> Journals</span>
                    <?php if ($specialty): ?>
                        <span class="badge bg-secondary"><i class="fas fa-list-ul"></i> <?php echo $stats['specialties']; ?> Categories</span>
                    <?php endif; ?>
                </div>
            </div>
        </div>
    </div>

    <!-- ============================================
    SEARCH SECTION
    ============================================ -->
    <div class="search-section">
        <div class="container">
            <div class="search-wrapper">
                <form method="GET" action="/browse" class="search-box">
                    <?php if ($specialtyId): ?>
                    <input type="hidden" name="specialty" value="<?php echo $specialtyId; ?>">
                    <?php endif; ?>
                    <input type="text" class="search-input" name="search" 
                           placeholder="Search for books, journals, authors, or topics..." 
                           value="<?php echo htmlspecialchars($searchQuery); ?>"
                           autocomplete="off">
                    <?php if (!empty($searchQuery)): ?>
                    <a href="/browse<?php echo $specialtyId ? '?specialty=' . $specialtyId : ''; ?>" class="search-clear-btn" title="Clear search">
                        <i class="fas fa-times"></i> Clear
                    </a>
                    <?php endif; ?>
                    <button type="submit" class="search-btn">
                        <i class="fas fa-search"></i> Search
                    </button>
                </form>
                
                <?php if (!empty($searchQuery)): ?>
                <div class="search-results-info">
                    Found <strong><?php echo count($books) + count($journals); ?></strong> result(s) for "<strong><?php echo htmlspecialchars($searchQuery); ?></strong>"
                    <?php if ($specialty): ?>
                    in <strong><?php echo htmlspecialchars($specialty['name']); ?></strong>
                    <?php endif; ?>
                </div>
                <?php endif; ?>
            </div>
        </div>
    </div>

    <!-- ============================================
    MAIN CONTENT
    ============================================ -->
    <div class="main-wrapper">
        <div class="container">
            <div class="row g-4">
                
                <!-- ============================================
                FILTER SIDEBAR - CATEGORIES (LEFT)
                On Mobile: Shows FIRST
                ============================================ -->
                <div class="col-lg-3">
                    <div class="filter-sidebar">
                        <div class="header">
                            <i class="fas fa-list-ul"></i> Categories
                        </div>
                        
                        <a href="/browse<?php echo !empty($searchQuery) ? '?search=' . urlencode($searchQuery) : ''; ?>" 
                           class="filter-item <?php echo $specialtyId == 0 ? 'active' : ''; ?>">
                            <span class="name"><i class="fas fa-th"></i> All Resources</span>
                            <span class="badge-count"><?php echo count($books) + count($journals); ?></span>
                        </a>
                        
                        <?php foreach ($allSpecialties as $s): 
                            $totalCount = $s['book_count'] + $s['journal_count'];
                            if ($totalCount == 0) continue;
                        ?>
                        <a href="/browse/<?php echo $s['id']; ?><?php echo !empty($searchQuery) ? '?search=' . urlencode($searchQuery) : ''; ?>" 
                           class="filter-item <?php echo $specialtyId == $s['id'] ? 'active' : ''; ?>">
                            <span class="name"><?php echo htmlspecialchars($s['name']); ?></span>
                            <span class="badge-count"><?php echo $totalCount; ?></span>
                        </a>
                        <?php endforeach; ?>
                        
                        <div class="filter-divider"></div>
                        
                        <div class="back-home-btn">
                            <a href="/" class="btn btn-outline-secondary btn-sm">
                                <i class="fas fa-arrow-left"></i> Back to Home
                            </a>
                        </div>
                    </div>
                </div>
                
                <!-- ============================================
                CONTENT - BOOKS & JOURNALS (RIGHT)
                On Mobile: Shows SECOND
                ============================================ -->
                <div class="col-lg-9 content-area">
                    
                    <!-- ============================================
                    BOOKS SECTION
                    ============================================ -->
                    <div class="section-header">
                        <h4><i class="fas fa-book text-primary"></i> Books</h4>
                        <span class="count"><?php echo count($books); ?> books found</span>
                    </div>
                    
                    <?php if (empty($books)): ?>
                        <div class="empty-state">
                            <div class="icon"><i class="fas fa-book-open"></i></div>
                            <h5>No Books Found</h5>
                            <p>No books are available <?php echo $specialty ? 'for this specialty' : 'at the moment'; ?>.</p>
                            <?php if (!empty($searchQuery)): ?>
                            <p class="mt-2">Try adjusting your search criteria.</p>
                            <?php endif; ?>
                        </div>
                    <?php else: ?>
                    <div class="items-grid">
                        <?php foreach ($books as $book): ?>
                        <div class="item-card">
                            <div class="cover">
                                <?php if (!empty($book['cover_image'])): ?>
                                <img src="/uploads/books/<?php echo $book['cover_image']; ?>" 
                                     alt="<?php echo htmlspecialchars($book['title'] ?? ''); ?>" loading="lazy">
                                <?php else: ?>
                                <div class="placeholder"><i class="fas fa-book"></i></div>
                                <?php endif; ?>
                                <span class="specialty-tag"><?php echo htmlspecialchars($book['specialty_name'] ?? ''); ?></span>
                            </div>
                            <div class="info">
                                <h6><?php echo htmlspecialchars($book['title'] ?? ''); ?></h6>
                                <div class="author"><?php echo htmlspecialchars($book['author'] ?? ''); ?></div>
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
                                    <i class="fas fa-lock"></i> Login
                                </a>
                                <?php endif; ?>
                            </div>
                        </div>
                        <?php endforeach; ?>
                    </div>
                    <?php endif; ?>
                    
                    <!-- ============================================
                    JOURNALS SECTION
                    ============================================ -->
                    <div class="section-header" style="margin-top: 32px;">
                        <h4><i class="fas fa-newspaper text-success"></i> Journals</h4>
                        <span class="count"><?php echo count($journals); ?> journals found</span>
                    </div>
                    
                    <?php if (empty($journals)): ?>
                        <div class="empty-state">
                            <div class="icon"><i class="fas fa-newspaper"></i></div>
                            <h5>No Journals Found</h5>
                            <p>No journals are available <?php echo $specialty ? 'for this specialty' : 'at the moment'; ?>.</p>
                            <?php if (!empty($searchQuery)): ?>
                            <p class="mt-2">Try adjusting your search criteria.</p>
                            <?php endif; ?>
                        </div>
                    <?php else: ?>
                    <div class="items-grid">
                        <?php foreach ($journals as $journal): ?>
                        <div class="item-card journal">
                            <div class="cover">
                                <div class="journal-icon"><i class="fas fa-file-alt"></i></div>
                                <span class="specialty-tag"><?php echo htmlspecialchars($journal['specialty_name'] ?? ''); ?></span>
                                <span class="journal-name-tag"><?php echo htmlspecialchars($journal['journal_name'] ?? ''); ?></span>
                            </div>
                            <div class="info">
                                <h6><?php echo htmlspecialchars($journal['title'] ?? ''); ?></h6>
                                <div class="meta">
                                    <?php if (!empty($journal['date'])): ?>
                                    <span><i class="far fa-calendar-alt"></i> <?php echo date('M Y', strtotime($journal['date'])); ?></span>
                                    <?php endif; ?>
                                    <?php if (!empty($journal['volume'])): ?>
                                    <span>Vol <?php echo $journal['volume']; ?></span>
                                    <?php endif; ?>
                                    <?php if (!empty($journal['issue'])): ?>
                                    <span>Issue <?php echo $journal['issue']; ?></span>
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
                                    <i class="fas fa-lock"></i> Login
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
    </div>

    <!-- ============================================
    FOOTER
    ============================================ -->
    <footer class="footer-main">
        <div class="container">
            <p>
                <strong>UCLP Academy</strong> &copy; <?php echo date('Y'); ?> 
                <span class="version">v2.0</span> &bull; 
                Powered by UniMed UniHealth Group
            </p>
        </div>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
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