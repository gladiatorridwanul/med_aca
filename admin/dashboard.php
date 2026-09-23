<?php
require_once __DIR__ . '/../includes/config.php';
require_once __DIR__ . '/../includes/functions.php';
require_once __DIR__ . '/../includes/auth.php';

Auth::requireAdmin();

$db = Database::getInstance()->getConnection();

// Get statistics
$stats = [
    'total_doctors' => $db->query("SELECT COUNT(*) as count FROM users WHERE user_type = 'doctor'")->fetch_assoc()['count'],
    'pending_doctors' => $db->query("SELECT COUNT(*) as count FROM users WHERE user_type = 'doctor' AND is_verified = 0")->fetch_assoc()['count'],
    'verified_doctors' => $db->query("SELECT COUNT(*) as count FROM users WHERE user_type = 'doctor' AND is_verified = 1")->fetch_assoc()['count'],
    'total_books' => $db->query("SELECT COUNT(*) as count FROM books")->fetch_assoc()['count'],
    'pending_books' => $db->query("SELECT COUNT(*) as count FROM books WHERE status = 'pending'")->fetch_assoc()['count'],
    'total_journals' => $db->query("SELECT COUNT(*) as count FROM journals")->fetch_assoc()['count'],
    'pending_journals' => $db->query("SELECT COUNT(*) as count FROM journals WHERE status = 'pending'")->fetch_assoc()['count'],
    'pending_requests' => $db->query("SELECT COUNT(*) as count FROM supply_requests WHERE status = 'pending'")->fetch_assoc()['count'],
    'total_requests' => $db->query("SELECT COUNT(*) as count FROM supply_requests")->fetch_assoc()['count'],
    'pending_downloads' => $db->query("SELECT COUNT(*) as count FROM download_permissions WHERE status = 'pending'")->fetch_assoc()['count'],
];

// Get pending doctors
$pendingDoctors = $db->query("
    SELECT id, name, email, bmdc_reg_no, specialty, created_at 
    FROM users 
    WHERE user_type = 'doctor' AND is_verified = 0 
    ORDER BY created_at DESC LIMIT 5
");

// Get pending books
$pendingBooks = $db->query("
    SELECT b.*, s.name as specialty_name, u.name as uploaded_by_name 
    FROM books b 
    LEFT JOIN specialties s ON b.specialty_id = s.id 
    LEFT JOIN users u ON b.uploaded_by = u.id 
    WHERE b.status = 'pending' 
    ORDER BY b.created_at DESC LIMIT 5
");

// Get pending journals
$pendingJournals = $db->query("
    SELECT j.*, s.name as specialty_name, u.name as uploaded_by_name 
    FROM journals j 
    LEFT JOIN specialties s ON j.specialty_id = s.id 
    LEFT JOIN users u ON j.uploaded_by = u.id 
    WHERE j.status = 'pending' 
    ORDER BY j.created_at DESC LIMIT 5
");

// Get pending supply requests
$pendingRequests = $db->query("
    SELECT sr.*, u.name as doctor_name, 
           CASE 
               WHEN sr.book_id IS NOT NULL THEN b.title 
               WHEN sr.journal_id IS NOT NULL THEN j.title 
           END as item_title
    FROM supply_requests sr 
    LEFT JOIN users u ON sr.user_id = u.id 
    LEFT JOIN books b ON sr.book_id = b.id 
    LEFT JOIN journals j ON sr.journal_id = j.id 
    WHERE sr.status = 'pending' 
    ORDER BY sr.request_date DESC LIMIT 5
");

// Get pending download permissions
$pendingDownloads = $db->query("
    SELECT dp.*, u.name as doctor_name,
           CASE 
               WHEN dp.item_type = 'book' THEN b.title 
               WHEN dp.item_type = 'journal' THEN j.title 
           END as item_title
    FROM download_permissions dp 
    LEFT JOIN users u ON dp.user_id = u.id 
    LEFT JOIN books b ON dp.item_type = 'book' AND dp.item_id = b.id 
    LEFT JOIN journals j ON dp.item_type = 'journal' AND dp.item_id = j.id 
    WHERE dp.status = 'pending' 
    ORDER BY dp.requested_at DESC LIMIT 5
");
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard - UCLP Academy</title>
    
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
            background: #ffffff;
            color: #000000;
            overflow-x: hidden;
            font-size: 16px;
        }
        
        /* ============================================
           MAIN CONTENT AREA
           ============================================ */
        .main-content {
            margin-left: 250px;
            padding: 20px 24px 24px;
            min-height: 100vh;
            transition: all 0.3s ease;
            max-width: calc(100% - 250px);
            overflow-x: hidden;
            background: #ffffff;
        }
        
        /* ============================================
           PAGE HEADER
           ============================================ */
        .page-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            flex-wrap: wrap;
            padding: 0 0 14px 0;
            border-bottom: 1px solid #eef1f5;
            margin-bottom: 18px;
        }
        .page-header h1 {
            font-weight: 700;
            font-size: 1.5rem;
            color: #000000;
            margin: 0;
            font-family: 'Cambria', Georgia, serif;
        }
        .page-header h1 i {
            color: #0d6efd;
            margin-right: 10px;
        }
        .page-header .welcome-text {
            color: #6c757d;
            font-size: 0.95rem;
            font-family: 'Cambria', Georgia, serif;
        }
        .page-header .welcome-text i {
            margin-right: 6px;
        }
        
        /* ============================================
           STATISTICS CARDS - FLEXIBLE GRID
           ============================================ */
        .stats-grid {
            display: grid;
            grid-template-columns: repeat(6, 1fr);
            gap: 14px;
            margin-bottom: 18px;
        }
        
        .stat-card {
            background: #f8f9fa;
            border-radius: 8px;
            padding: 14px 16px;
            border: 1px solid #eef1f5;
            transition: all 0.2s ease;
        }
        .stat-card:hover {
            transform: translateY(-3px);
            box-shadow: 0 4px 15px rgba(0,0,0,0.05);
        }
        
        .stat-card .stat-icon {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            width: 36px;
            height: 36px;
            border-radius: 8px;
            font-size: 1rem;
            margin-bottom: 8px;
        }
        .stat-card .stat-icon.blue { background: #e8f0fe; color: #0d6efd; }
        .stat-card .stat-icon.green { background: #e8f5e9; color: #198754; }
        .stat-card .stat-icon.orange { background: #fff3e0; color: #f39c12; }
        .stat-card .stat-icon.red { background: #fce4ec; color: #dc3545; }
        .stat-card .stat-icon.purple { background: #f3e5f5; color: #6f42c1; }
        .stat-card .stat-icon.cyan { background: #e0f7fa; color: #0dcaf0; }
        
        .stat-card .stat-number {
            font-size: 1.6rem;
            font-weight: 700;
            color: #000000;
            line-height: 1.2;
            font-family: 'Cambria', Georgia, serif;
        }
        .stat-card .stat-label {
            font-size: 0.75rem;
            color: #6c757d;
            font-weight: 500;
            font-family: 'Cambria', Georgia, serif;
            margin-top: 2px;
        }
        .stat-card .stat-link {
            font-size: 0.7rem;
            color: #0d6efd;
            text-decoration: none;
            font-weight: 600;
            display: inline-block;
            margin-top: 6px;
            font-family: 'Cambria', Georgia, serif;
        }
        .stat-card .stat-link:hover {
            text-decoration: underline;
        }
        
        .stat-card .badge-pending {
            font-size: 0.55rem;
            padding: 2px 10px;
            border-radius: 10px;
            background: #fff3e0;
            color: #f39c12;
            font-weight: 600;
            margin-left: 4px;
        }
        
        /* ============================================
           TABLES - PENDING TASKS (2 COLUMN GRID)
           ============================================ */
        .tables-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 18px;
        }
        
        .table-card {
            background: #f8f9fa;
            border-radius: 8px;
            border: 1px solid #eef1f5;
            overflow: hidden;
        }
        
        .table-card .table-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 12px 16px;
            border-bottom: 1px solid #eef1f5;
            flex-wrap: wrap;
            gap: 6px;
            background: #f8f9fa;
        }
        .table-card .table-header h5 {
            font-weight: 700;
            font-size: 0.95rem;
            color: #000000;
            margin: 0;
            font-family: 'Cambria', Georgia, serif;
        }
        .table-card .table-header h5 i {
            margin-right: 8px;
        }
        .table-card .table-header .badge-count {
            font-size: 0.7rem;
            padding: 2px 12px;
            border-radius: 10px;
            font-weight: 600;
        }
        .table-card .table-header .badge-count.orange {
            background: #fff3e0;
            color: #f39c12;
        }
        .table-card .table-header .badge-count.blue {
            background: #e8f0fe;
            color: #0d6efd;
        }
        .table-card .table-header .badge-count.green {
            background: #e8f5e9;
            color: #198754;
        }
        
        .table-card .table-body {
            padding: 0;
            overflow-x: auto;
            -webkit-overflow-scrolling: touch;
        }
        
        .table-card .table-body table {
            margin: 0;
            font-family: 'Cambria', Georgia, serif;
            font-size: 0.88rem;
            width: 100%;
            min-width: 400px;
            background: #ffffff;
        }
        .table-card .table-body table thead th {
            background: #f8f9fa;
            color: #495057;
            font-weight: 600;
            border-bottom: 2px solid #eef1f5;
            padding: 8px 14px;
            white-space: nowrap;
            font-size: 0.72rem;
            text-transform: uppercase;
            letter-spacing: 0.3px;
        }
        .table-card .table-body table tbody td {
            padding: 8px 14px;
            vertical-align: middle;
            border-bottom: 1px solid #f0f4f8;
            color: #000000;
            font-size: 0.88rem;
        }
        .table-card .table-body table tbody tr:hover {
            background: #f8f9fa;
        }
        .table-card .table-body table tbody tr:last-child td {
            border-bottom: none;
        }
        
        .table-card .table-footer {
            padding: 10px 16px;
            border-top: 1px solid #eef1f5;
            background: #f8f9fa;
        }
        .table-card .table-footer .btn {
            font-family: 'Cambria', Georgia, serif;
            font-size: 0.8rem;
            font-weight: 600;
            padding: 4px 16px;
            border-radius: 4px;
        }
        
        .badge-status {
            padding: 3px 12px;
            border-radius: 12px;
            font-size: 0.68rem;
            font-weight: 600;
            font-family: 'Cambria', Georgia, serif;
            display: inline-block;
        }
        .badge-status.pending { background: #fff3e0; color: #f39c12; }
        .badge-status.approved { background: #e8f5e9; color: #198754; }
        .badge-status.rejected { background: #fce4ec; color: #dc3545; }
        .badge-status.verified { background: #e8f5e9; color: #198754; }
        .badge-status.unverified { background: #fce4ec; color: #dc3545; }
        
        .action-link {
            font-size: 0.72rem;
            padding: 3px 10px;
            border-radius: 4px;
            text-decoration: none;
            font-weight: 600;
            font-family: 'Cambria', Georgia, serif;
            display: inline-block;
            transition: all 0.2s ease;
        }
        .action-link:hover {
            opacity: 0.8;
            transform: translateY(-1px);
        }
        .action-link.primary { background: #e8f0fe; color: #0d6efd; }
        .action-link.success { background: #e8f5e9; color: #198754; }
        .action-link.danger { background: #fce4ec; color: #dc3545; }
        .action-link.warning { background: #fff3e0; color: #f39c12; }
        
        .empty-state {
            text-align: center;
            padding: 24px 16px;
            background: #ffffff;
        }
        .empty-state .icon {
            font-size: 1.8rem;
            color: #198754;
            margin-bottom: 6px;
        }
        .empty-state p {
            color: #6c757d;
            font-family: 'Cambria', Georgia, serif;
            font-size: 0.88rem;
            margin: 0;
        }
        
        /* ============================================
           RESPONSIVE
           ============================================ */
        
        /* Desktop & Laptop */
        @media (min-width: 1200px) {
            .stats-grid {
                grid-template-columns: repeat(6, 1fr);
            }
            .tables-grid {
                grid-template-columns: 1fr 1fr;
            }
        }
        
        /* Small Laptop */
        @media (min-width: 992px) and (max-width: 1199px) {
            .stats-grid {
                grid-template-columns: repeat(3, 1fr);
            }
            .tables-grid {
                grid-template-columns: 1fr 1fr;
            }
            .main-content {
                padding: 16px 18px 18px;
            }
            .table-card .table-body table {
                min-width: 350px;
            }
        }
        
        /* Tablet - Hide Sidebar */
        @media (max-width: 991.98px) {
            .main-content {
                margin-left: 0 !important;
                max-width: 100% !important;
                padding: 14px 16px 18px;
            }
            .stats-grid {
                grid-template-columns: repeat(3, 1fr);
                gap: 12px;
            }
            .tables-grid {
                grid-template-columns: 1fr;
                gap: 14px;
            }
            .page-header h1 {
                font-size: 1.3rem;
            }
            .page-header .welcome-text {
                font-size: 0.9rem;
            }
            .stat-card .stat-number {
                font-size: 1.4rem;
            }
        }
        
        /* Mobile */
        @media (max-width: 575.98px) {
            .main-content {
                padding: 10px 8px 14px;
            }
            .stats-grid {
                grid-template-columns: repeat(3, 1fr);
                gap: 8px;
            }
            .stat-card {
                padding: 10px 12px;
            }
            .stat-card .stat-number {
                font-size: 1.15rem;
            }
            .stat-card .stat-icon {
                width: 28px;
                height: 28px;
                font-size: 0.8rem;
                margin-bottom: 4px;
            }
            .stat-card .stat-label {
                font-size: 0.62rem;
            }
            .stat-card .stat-link {
                font-size: 0.6rem;
            }
            .page-header {
                padding-bottom: 10px;
                margin-bottom: 14px;
            }
            .page-header h1 {
                font-size: 1.15rem;
            }
            .page-header h1 i {
                font-size: 1rem;
            }
            .page-header .welcome-text {
                font-size: 0.8rem;
                margin-top: 4px;
                width: 100%;
            }
            .table-card .table-header {
                padding: 10px 12px;
            }
            .table-card .table-header h5 {
                font-size: 0.85rem;
            }
            .table-card .table-body table {
                min-width: 320px;
                font-size: 0.78rem;
            }
            .table-card .table-body table thead th {
                padding: 6px 10px;
                font-size: 0.62rem;
            }
            .table-card .table-body table tbody td {
                padding: 6px 10px;
                font-size: 0.78rem;
            }
            .table-card .table-footer {
                padding: 8px 12px;
            }
            .table-card .table-footer .btn {
                font-size: 0.7rem;
                padding: 3px 12px;
            }
            .action-link {
                font-size: 0.62rem;
                padding: 2px 8px;
            }
            .badge-status {
                font-size: 0.58rem;
                padding: 2px 8px;
            }
            .empty-state {
                padding: 16px 12px;
            }
            .empty-state .icon {
                font-size: 1.4rem;
            }
            .empty-state p {
                font-size: 0.78rem;
            }
            .tables-grid {
                gap: 12px;
            }
            .table-card .table-header .badge-count {
                font-size: 0.58rem;
                padding: 2px 8px;
            }
            .stat-card .badge-pending {
                font-size: 0.48rem;
                padding: 1px 6px;
            }
        }
        
        /* Extra Small */
        @media (max-width: 400px) {
            .stats-grid {
                grid-template-columns: repeat(2, 1fr);
                gap: 6px;
            }
            .stat-card {
                padding: 8px 10px;
            }
            .stat-card .stat-number {
                font-size: 1rem;
            }
            .stat-card .stat-icon {
                width: 24px;
                height: 24px;
                font-size: 0.7rem;
            }
            .stat-card .stat-label {
                font-size: 0.55rem;
            }
            .table-card .table-body table {
                min-width: 280px;
                font-size: 0.72rem;
            }
            .main-content {
                padding: 8px 4px 10px;
            }
            .page-header h1 {
                font-size: 1rem;
            }
        }
        
        /* ============================================
           DARK MODE SUPPORT - Override to keep white
           ============================================ */
        @media (prefers-color-scheme: dark) {
            body {
                background: #ffffff !important;
            }
            .main-content {
                background: #ffffff !important;
            }
            .stat-card {
                background: #f8f9fa !important;
                border-color: #eef1f5 !important;
            }
            .stat-card .stat-number {
                color: #000000 !important;
            }
            .stat-card .stat-label {
                color: #6c757d !important;
            }
            .stat-card .stat-icon.blue { background: #e8f0fe !important; color: #0d6efd !important; }
            .stat-card .stat-icon.green { background: #e8f5e9 !important; color: #198754 !important; }
            .stat-card .stat-icon.orange { background: #fff3e0 !important; color: #f39c12 !important; }
            .stat-card .stat-icon.red { background: #fce4ec !important; color: #dc3545 !important; }
            .stat-card .stat-icon.purple { background: #f3e5f5 !important; color: #6f42c1 !important; }
            .stat-card .stat-icon.cyan { background: #e0f7fa !important; color: #0dcaf0 !important; }
            .table-card {
                background: #f8f9fa !important;
                border-color: #eef1f5 !important;
            }
            .table-card .table-header {
                background: #f8f9fa !important;
                border-bottom-color: #eef1f5 !important;
            }
            .table-card .table-header h5 {
                color: #000000 !important;
            }
            .table-card .table-body table {
                background: #ffffff !important;
            }
            .table-card .table-body table thead th {
                background: #f8f9fa !important;
                color: #495057 !important;
                border-bottom-color: #eef1f5 !important;
            }
            .table-card .table-body table tbody td {
                color: #000000 !important;
                border-bottom-color: #f0f4f8 !important;
            }
            .table-card .table-body table tbody tr:hover {
                background: #f8f9fa !important;
            }
            .table-card .table-footer {
                background: #f8f9fa !important;
                border-top-color: #eef1f5 !important;
            }
            .empty-state {
                background: #ffffff !important;
            }
            .empty-state p {
                color: #6c757d !important;
            }
            .page-header {
                border-bottom-color: #eef1f5 !important;
            }
            .page-header h1 {
                color: #000000 !important;
            }
            .page-header .welcome-text {
                color: #6c757d !important;
            }
            .badge-status.pending { background: #fff3e0 !important; color: #f39c12 !important; }
            .badge-status.approved { background: #e8f5e9 !important; color: #198754 !important; }
            .badge-status.rejected { background: #fce4ec !important; color: #dc3545 !important; }
            .badge-status.verified { background: #e8f5e9 !important; color: #198754 !important; }
            .badge-status.unverified { background: #fce4ec !important; color: #dc3545 !important; }
            .action-link.primary { background: #e8f0fe !important; color: #0d6efd !important; }
            .action-link.success { background: #e8f5e9 !important; color: #198754 !important; }
            .action-link.danger { background: #fce4ec !important; color: #dc3545 !important; }
            .action-link.warning { background: #fff3e0 !important; color: #f39c12 !important; }
        }
    </style>
</head>
<body>
    <!-- ============================================
    NAVIGATION
    ============================================ -->
    <?php include __DIR__ . '/../includes/admin_nav.php'; ?>
    
    <!-- ============================================
    SIDEBAR
    ============================================ -->
    <div class="container-fluid">
        <div class="row">
            <?php include __DIR__ . '/../includes/admin_sidebar.php'; ?>
            
            <!-- ============================================
            MAIN CONTENT
            ============================================ -->
            <main class="main-content">
                <!-- Page Header -->
                <div class="page-header">
                    <h1>
                        <i class="fas fa-chart-line"></i> Dashboard
                    </h1>
                    <div class="welcome-text">
                        <i class="fas fa-user-cog"></i> Welcome, <?php echo htmlspecialchars($_SESSION['user_name']); ?>
                    </div>
                </div>

                <!-- ============================================
                STATISTICS CARDS
                ============================================ -->
                <div class="stats-grid">
                    <!-- Total Doctors -->
                    <div class="stat-card">
                        <div class="stat-icon blue"><i class="fas fa-users"></i></div>
                        <div class="stat-number"><?php echo $stats['total_doctors']; ?></div>
                        <div class="stat-label">Total Doctors</div>
                        <a href="/admin/doctors" class="stat-link">View All <i class="fas fa-arrow-right"></i></a>
                    </div>
                    
                    <!-- Pending Verification -->
                    <div class="stat-card">
                        <div class="stat-icon orange"><i class="fas fa-clock"></i></div>
                        <div class="stat-number"><?php echo $stats['pending_doctors']; ?></div>
                        <div class="stat-label">Pending Verification</div>
                        <?php if ($stats['pending_doctors'] > 0): ?>
                            <a href="/admin/verify" class="stat-link">
                                Verify Now <i class="fas fa-arrow-right"></i>
                                <span class="badge-pending"><?php echo $stats['pending_doctors']; ?></span>
                            </a>
                        <?php else: ?>
                            <span class="stat-link" style="color: #198754;">All Verified <i class="fas fa-check-circle"></i></span>
                        <?php endif; ?>
                    </div>
                    
                    <!-- Total Books -->
                    <div class="stat-card">
                        <div class="stat-icon green"><i class="fas fa-book"></i></div>
                        <div class="stat-number"><?php echo $stats['total_books']; ?></div>
                        <div class="stat-label">Total Books</div>
                        <?php if ($stats['pending_books'] > 0): ?>
                            <a href="/admin/books" class="stat-link">
                                <?php echo $stats['pending_books']; ?> Pending <i class="fas fa-arrow-right"></i>
                            </a>
                        <?php else: ?>
                            <span class="stat-link" style="color: #198754;">All Approved <i class="fas fa-check-circle"></i></span>
                        <?php endif; ?>
                    </div>
                    
                    <!-- Total Journals -->
                    <div class="stat-card">
                        <div class="stat-icon purple"><i class="fas fa-newspaper"></i></div>
                        <div class="stat-number"><?php echo $stats['total_journals']; ?></div>
                        <div class="stat-label">Total Journals</div>
                        <?php if ($stats['pending_journals'] > 0): ?>
                            <a href="/admin/journals" class="stat-link">
                                <?php echo $stats['pending_journals']; ?> Pending <i class="fas fa-arrow-right"></i>
                            </a>
                        <?php else: ?>
                            <span class="stat-link" style="color: #198754;">All Approved <i class="fas fa-check-circle"></i></span>
                        <?php endif; ?>
                    </div>
                    
                    <!-- Supply Requests -->
                    <div class="stat-card">
                        <div class="stat-icon cyan"><i class="fas fa-truck"></i></div>
                        <div class="stat-number"><?php echo $stats['total_requests']; ?></div>
                        <div class="stat-label">Supply Requests</div>
                        <?php if ($stats['pending_requests'] > 0): ?>
                            <a href="/admin/requests" class="stat-link">
                                <?php echo $stats['pending_requests']; ?> Pending <i class="fas fa-arrow-right"></i>
                            </a>
                        <?php else: ?>
                            <span class="stat-link" style="color: #198754;">No Pending <i class="fas fa-check-circle"></i></span>
                        <?php endif; ?>
                    </div>
                    
                    <!-- Download Permissions -->
                    <div class="stat-card">
                        <div class="stat-icon red"><i class="fas fa-download"></i></div>
                        <div class="stat-number"><?php echo $stats['pending_downloads']; ?></div>
                        <div class="stat-label">Pending Downloads</div>
                        <?php if ($stats['pending_downloads'] > 0): ?>
                            <a href="/admin/download-permissions" class="stat-link">
                                Review Now <i class="fas fa-arrow-right"></i>
                                <span class="badge-pending"><?php echo $stats['pending_downloads']; ?></span>
                            </a>
                        <?php else: ?>
                            <span class="stat-link" style="color: #198754;">All Approved <i class="fas fa-check-circle"></i></span>
                        <?php endif; ?>
                    </div>
                </div>

                <!-- ============================================
                PENDING TASKS TABLES - 2 COLUMN GRID
                ============================================ -->
                <div class="tables-grid">
                    
                    <!-- PENDING DOCTORS -->
                    <div class="table-card">
                        <div class="table-header">
                            <h5><i class="fas fa-user-check" style="color: #f39c12;"></i> Pending Doctors</h5>
                            <span class="badge-count orange"><?php echo $stats['pending_doctors']; ?></span>
                        </div>
                        <div class="table-body">
                            <?php if ($pendingDoctors->num_rows > 0): ?>
                            <table>
                                <thead>
                                    <tr>
                                        <th>Name</th>
                                        <th>Email</th>
                                        <th>Action</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <?php while ($doctor = $pendingDoctors->fetch_assoc()): ?>
                                    <tr>
                                        <td><strong><?php echo htmlspecialchars($doctor['name']); ?></strong></td>
                                        <td><small><?php echo htmlspecialchars($doctor['email']); ?></small></td>
                                        <td>
                                            <a href="/admin/verify" class="action-link primary">
                                                <i class="fas fa-check"></i> Verify
                                            </a>
                                        </td>
                                    </tr>
                                    <?php endwhile; ?>
                                </tbody>
                            </table>
                            <?php else: ?>
                            <div class="empty-state">
                                <div class="icon"><i class="fas fa-check-circle"></i></div>
                                <p>All doctors are verified. No pending verifications.</p>
                            </div>
                            <?php endif; ?>
                        </div>
                        <?php if ($pendingDoctors->num_rows > 0): ?>
                        <div class="table-footer">
                            <a href="/admin/verify" class="btn btn-primary">
                                <i class="fas fa-eye"></i> View All
                            </a>
                        </div>
                        <?php endif; ?>
                    </div>
                    
                    <!-- PENDING BOOKS -->
                    <div class="table-card">
                        <div class="table-header">
                            <h5><i class="fas fa-book" style="color: #f39c12;"></i> Pending Books</h5>
                            <span class="badge-count orange"><?php echo $stats['pending_books']; ?></span>
                        </div>
                        <div class="table-body">
                            <?php if ($pendingBooks->num_rows > 0): ?>
                            <table>
                                <thead>
                                    <tr>
                                        <th>Title</th>
                                        <th>Specialty</th>
                                        <th>Action</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <?php while ($book = $pendingBooks->fetch_assoc()): ?>
                                    <tr>
                                        <td><strong><?php echo htmlspecialchars($book['title']); ?></strong></td>
                                        <td><small><?php echo htmlspecialchars($book['specialty_name']); ?></small></td>
                                        <td>
                                            <a href="/admin/books" class="action-link primary">
                                                <i class="fas fa-edit"></i> Review
                                            </a>
                                        </td>
                                    </tr>
                                    <?php endwhile; ?>
                                </tbody>
                            </table>
                            <?php else: ?>
                            <div class="empty-state">
                                <div class="icon"><i class="fas fa-check-circle"></i></div>
                                <p>All books are approved. No pending approvals.</p>
                            </div>
                            <?php endif; ?>
                        </div>
                        <?php if ($pendingBooks->num_rows > 0): ?>
                        <div class="table-footer">
                            <a href="/admin/books" class="btn btn-primary">
                                <i class="fas fa-eye"></i> View All
                            </a>
                        </div>
                        <?php endif; ?>
                    </div>
                    
                    <!-- PENDING JOURNALS -->
                    <div class="table-card">
                        <div class="table-header">
                            <h5><i class="fas fa-newspaper" style="color: #f39c12;"></i> Pending Journals</h5>
                            <span class="badge-count orange"><?php echo $stats['pending_journals']; ?></span>
                        </div>
                        <div class="table-body">
                            <?php if ($pendingJournals->num_rows > 0): ?>
                            <table>
                                <thead>
                                    <tr>
                                        <th>Title</th>
                                        <th>Journal Name</th>
                                        <th>Action</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <?php while ($journal = $pendingJournals->fetch_assoc()): ?>
                                    <tr>
                                        <td><strong><?php echo htmlspecialchars($journal['title']); ?></strong></td>
                                        <td><small><?php echo htmlspecialchars($journal['journal_name']); ?></small></td>
                                        <td>
                                            <a href="/admin/journals" class="action-link primary">
                                                <i class="fas fa-edit"></i> Review
                                            </a>
                                        </td>
                                    </tr>
                                    <?php endwhile; ?>
                                </tbody>
                            </table>
                            <?php else: ?>
                            <div class="empty-state">
                                <div class="icon"><i class="fas fa-check-circle"></i></div>
                                <p>All journals are approved. No pending approvals.</p>
                            </div>
                            <?php endif; ?>
                        </div>
                        <?php if ($pendingJournals->num_rows > 0): ?>
                        <div class="table-footer">
                            <a href="/admin/journals" class="btn btn-primary">
                                <i class="fas fa-eye"></i> View All
                            </a>
                        </div>
                        <?php endif; ?>
                    </div>
                    
                    <!-- SUPPLY REQUESTS -->
                    <div class="table-card">
                        <div class="table-header">
                            <h5><i class="fas fa-truck" style="color: #f39c12;"></i> Supply Requests</h5>
                            <span class="badge-count orange"><?php echo $stats['pending_requests']; ?></span>
                        </div>
                        <div class="table-body">
                            <?php if ($pendingRequests->num_rows > 0): ?>
                            <table>
                                <thead>
                                    <tr>
                                        <th>Doctor</th>
                                        <th>Item</th>
                                        <th>Action</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <?php while ($req = $pendingRequests->fetch_assoc()): ?>
                                    <tr>
                                        <td><strong><?php echo htmlspecialchars($req['doctor_name']); ?></strong></td>
                                        <td><small><?php echo htmlspecialchars($req['item_title'] ?? 'N/A'); ?></small></td>
                                        <td>
                                            <a href="/admin/requests" class="action-link primary">
                                                <i class="fas fa-check"></i> Process
                                            </a>
                                        </td>
                                    </tr>
                                    <?php endwhile; ?>
                                </tbody>
                            </table>
                            <?php else: ?>
                            <div class="empty-state">
                                <div class="icon"><i class="fas fa-check-circle"></i></div>
                                <p>No pending supply requests.</p>
                            </div>
                            <?php endif; ?>
                        </div>
                        <?php if ($pendingRequests->num_rows > 0): ?>
                        <div class="table-footer">
                            <a href="/admin/requests" class="btn btn-primary">
                                <i class="fas fa-eye"></i> View All
                            </a>
                        </div>
                        <?php endif; ?>
                    </div>
                    
                    <!-- DOWNLOAD PERMISSIONS -->
                    <div class="table-card">
                        <div class="table-header">
                            <h5><i class="fas fa-download" style="color: #f39c12;"></i> Download Permissions</h5>
                            <span class="badge-count orange"><?php echo $stats['pending_downloads']; ?></span>
                        </div>
                        <div class="table-body">
                            <?php if ($pendingDownloads->num_rows > 0): ?>
                            <table>
                                <thead>
                                    <tr>
                                        <th>Doctor</th>
                                        <th>Item</th>
                                        <th>Action</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <?php while ($dl = $pendingDownloads->fetch_assoc()): ?>
                                    <tr>
                                        <td><strong><?php echo htmlspecialchars($dl['doctor_name']); ?></strong></td>
                                        <td><small><?php echo htmlspecialchars($dl['item_title'] ?? 'N/A'); ?></small></td>
                                        <td>
                                            <a href="/admin/download-permissions" class="action-link primary">
                                                <i class="fas fa-check"></i> Review
                                            </a>
                                        </td>
                                    </tr>
                                    <?php endwhile; ?>
                                </tbody>
                            </table>
                            <?php else: ?>
                            <div class="empty-state">
                                <div class="icon"><i class="fas fa-check-circle"></i></div>
                                <p>No pending download permissions.</p>
                            </div>
                            <?php endif; ?>
                        </div>
                        <?php if ($pendingDownloads->num_rows > 0): ?>
                        <div class="table-footer">
                            <a href="/admin/download-permissions" class="btn btn-primary">
                                <i class="fas fa-eye"></i> View All
                            </a>
                        </div>
                        <?php endif; ?>
                    </div>
                    
                    <!-- RECENT ACTIVITIES -->
                    <div class="table-card">
                        <div class="table-header">
                            <h5><i class="fas fa-history" style="color: #0d6efd;"></i> Recent Activities</h5>
                            <span class="badge-count blue">Latest</span>
                        </div>
                        <div class="table-body">
                            <?php
                            $activities = $db->query("
                                SELECT action, user_type, created_at, 
                                       COALESCE(
                                           (SELECT name FROM users WHERE id = audit_trail.user_id),
                                           'System'
                                       ) as user_name
                                FROM audit_trail 
                                ORDER BY created_at DESC LIMIT 5
                            ");
                            ?>
                            <?php if ($activities->num_rows > 0): ?>
                            <table>
                                <thead>
                                    <tr>
                                        <th>User</th>
                                        <th>Action</th>
                                        <th>Time</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <?php while ($activity = $activities->fetch_assoc()): ?>
                                    <tr>
                                        <td><strong><?php echo htmlspecialchars($activity['user_name']); ?></strong></td>
                                        <td><small><?php echo htmlspecialchars($activity['action']); ?></small></td>
                                        <td><small><?php echo date('M d, H:i', strtotime($activity['created_at'])); ?></small></td>
                                    </tr>
                                    <?php endwhile; ?>
                                </tbody>
                            </table>
                            <?php else: ?>
                            <div class="empty-state">
                                <div class="icon"><i class="fas fa-inbox"></i></div>
                                <p>No activities recorded yet.</p>
                            </div>
                            <?php endif; ?>
                        </div>
                        <div class="table-footer">
                            <a href="/admin/audit" class="btn btn-primary">
                                <i class="fas fa-eye"></i> View All
                            </a>
                        </div>
                    </div>
                    
                </div>
            </main>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="/assets/js/custom.js"></script>
</body>
</html>