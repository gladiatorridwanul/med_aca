<?php
require_once __DIR__ . '/../includes/config.php';
require_once __DIR__ . '/../includes/functions.php';
require_once __DIR__ . '/../includes/auth.php';

Auth::requireAdmin();

$journalId = isset($_GET['id']) ? intval($_GET['id']) : 0;
if (!$journalId) {
    header("Location: /admin/manage_journals.php");
    exit;
}

$db = Database::getInstance()->getConnection();
$stmt = $db->prepare("SELECT * FROM journals WHERE id = ?");
$stmt->bind_param("i", $journalId);
$stmt->execute();
$result = $stmt->get_result();
$journal = $result->fetch_assoc();
$stmt->close();

if (!$journal) {
    header("Location: /admin/manage_journals.php");
    exit;
}

$error = null;
$success = null;
$specialties = getAllSpecialties();

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $title = sanitize($_POST['title'] ?? '');
    $journal_name = sanitize($_POST['journal_name'] ?? '');
    $specialty_id = intval($_POST['specialty_id'] ?? 0);
    $issue = sanitize($_POST['issue'] ?? '');
    $date = !empty($_POST['date']) ? $_POST['date'] : null;
    $volume = sanitize($_POST['volume'] ?? '');
    $pages = sanitize($_POST['pages'] ?? '');
    $doi = sanitize($_POST['doi'] ?? '');
    $abstract = sanitize($_POST['abstract'] ?? '');
    $is_watermarked = isset($_POST['is_watermarked']) ? 1 : 0;
    $status = sanitize($_POST['status'] ?? 'pending');
    
    // VALIDATE STATUS - Only allow valid enum values
    $valid_statuses = ['pending', 'approved', 'rejected'];
    if (!in_array($status, $valid_statuses)) {
        $status = 'pending';
    }
    
    if ($title && $journal_name && $specialty_id) {
        // Handle file upload
        $filePath = $journal['file_path'];
        if (isset($_FILES['journal_file']) && $_FILES['journal_file']['error'] === UPLOAD_ERR_OK) {
            $uploadResult = uploadFile($_FILES['journal_file'], JOURNAL_UPLOAD_PATH, ['pdf']);
            if ($uploadResult['success']) {
                if ($journal['file_path'] && file_exists(JOURNAL_UPLOAD_PATH . $journal['file_path'])) {
                    unlink(JOURNAL_UPLOAD_PATH . $journal['file_path']);
                }
                $filePath = $uploadResult['filename'];
            } else {
                $error = 'File upload failed: ' . $uploadResult['error'];
            }
        }
        
        if (!$error) {
            // Use a simple query with escaped values
            $title_escaped = $db->real_escape_string($title);
            $journal_name_escaped = $db->real_escape_string($journal_name);
            $issue_escaped = $db->real_escape_string($issue);
            $volume_escaped = $db->real_escape_string($volume);
            $pages_escaped = $db->real_escape_string($pages);
            $doi_escaped = $db->real_escape_string($doi);
            $abstract_escaped = $db->real_escape_string($abstract);
            $filePath_escaped = $db->real_escape_string($filePath);
            $status_escaped = $db->real_escape_string($status);
            
            $date_value = $date ? "'$date'" : "NULL";
            
            $sql = "UPDATE journals SET 
                    title = '$title_escaped',
                    journal_name = '$journal_name_escaped',
                    specialty_id = $specialty_id,
                    issue = '$issue_escaped',
                    date = $date_value,
                    volume = '$volume_escaped',
                    pages = '$pages_escaped',
                    doi = '$doi_escaped',
                    abstract = '$abstract_escaped',
                    file_path = '$filePath_escaped',
                    is_watermarked = $is_watermarked,
                    status = '$status_escaped',
                    updated_at = NOW()
                    WHERE id = $journalId";
            
            if ($db->query($sql)) {
                logActivity($_SESSION['user_id'], 'Updated Journal', "Updated journal ID: $journalId");
                $success = "Journal updated successfully.";
                // Refresh journal data
                $stmt2 = $db->prepare("SELECT * FROM journals WHERE id = ?");
                $stmt2->bind_param("i", $journalId);
                $stmt2->execute();
                $result2 = $stmt2->get_result();
                $journal = $result2->fetch_assoc();
                $stmt2->close();
            } else {
                $error = "Failed to update journal: " . $db->error;
            }
        }
    } else {
        $error = "Please fill in all required fields.";
    }
}
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Journal - UCLP Academy</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Cambria&display=swap" rel="stylesheet">
    
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        
        body {
            font-family: 'Cambria', Georgia, serif;
            background: #ffffff;
            color: #000000;
            overflow-x: hidden;
        }
        
        /* ============================================
           MAIN CONTENT AREA
           ============================================ */
        .main-content {
            margin-left: 250px;
            padding: 16px 20px 20px;
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
            padding: 0 0 12px 0;
            border-bottom: 1px solid #eef1f5;
            margin-bottom: 16px;
        }
        .page-header h1 {
            font-weight: 700;
            font-size: 1.3rem;
            color: #000000;
            margin: 0;
            font-family: 'Cambria', Georgia, serif;
        }
        .page-header h1 i {
            color: #198754;
            margin-right: 8px;
        }
        .page-header .btn-group-header {
            display: flex;
            gap: 8px;
            flex-wrap: wrap;
        }
        .page-header .btn-group-header .btn {
            font-family: 'Cambria', Georgia, serif;
            font-weight: 600;
            font-size: 0.8rem;
            padding: 5px 14px;
            border-radius: 6px;
        }
        
        /* ============================================
           FORM SECTIONS
           ============================================ */
        .form-grid {
            display: grid;
            grid-template-columns: 2fr 1fr;
            gap: 16px;
        }
        
        .form-card {
            background: #f8f9fa;
            border-radius: 8px;
            border: 1px solid #eef1f5;
            overflow: hidden;
        }
        
        .form-card .card-header {
            padding: 10px 14px;
            border-bottom: 1px solid #eef1f5;
            background: #f8f9fa;
            font-weight: 700;
            font-size: 0.85rem;
            color: #000000;
            font-family: 'Cambria', Georgia, serif;
        }
        .form-card .card-header i {
            margin-right: 6px;
        }
        .form-card .card-body {
            padding: 16px;
        }
        
        .form-section {
            background: #ffffff;
            padding: 14px 16px;
            border-radius: 6px;
            border: 1px solid #eef1f5;
            margin-bottom: 14px;
        }
        .form-section:last-child {
            margin-bottom: 0;
        }
        .form-section .section-title {
            font-weight: 700;
            font-size: 0.78rem;
            color: #198754;
            margin-bottom: 12px;
            font-family: 'Cambria', Georgia, serif;
        }
        
        /* ============================================
           FORM ELEMENTS
           ============================================ */
        .form-label {
            font-family: 'Cambria', Georgia, serif;
            font-weight: 600;
            color: #000000;
            font-size: 0.8rem;
        }
        .form-control, .form-select {
            border-radius: 6px;
            border: 1.5px solid #eef1f5;
            font-family: 'Cambria', Georgia, serif;
            font-size: 0.85rem;
            color: #000000;
            background: #ffffff;
            padding: 6px 12px;
        }
        .form-control:focus, .form-select:focus {
            border-color: #198754;
            box-shadow: 0 0 0 3px rgba(25, 135, 84, 0.08);
        }
        .form-control:disabled {
            background: #f8f9fa;
            color: #6c757d;
        }
        .form-check-label {
            font-family: 'Cambria', Georgia, serif;
            color: #000000;
            font-size: 0.82rem;
        }
        
        .btn {
            font-family: 'Cambria', Georgia, serif;
            font-weight: 600;
            font-size: 0.82rem;
            padding: 5px 16px;
            border-radius: 6px;
        }
        .btn-success { background: #198754; border: none; }
        .btn-success:hover { background: #157347; }
        .btn-secondary { background: #6c757d; border: none; }
        .btn-secondary:hover { background: #5a6268; }
        .btn-outline-success { border-color: #198754; color: #198754; }
        .btn-outline-success:hover { background: #198754; color: #fff; }
        .btn-outline-primary { border-color: #0d6efd; color: #0d6efd; }
        .btn-outline-primary:hover { background: #0d6efd; color: #fff; }
        
        /* ============================================
           FILE INFO
           ============================================ */
        .file-info {
            background: #f8f9fa;
            padding: 8px 12px;
            border-radius: 6px;
            border-left: 3px solid #198754;
            margin-top: 6px;
            font-family: 'Cambria', Georgia, serif;
            font-size: 0.75rem;
            color: #000000;
        }
        .file-info strong {
            color: #198754;
        }
        
        /* ============================================
           STATS SIDEBAR
           ============================================ */
        .stat-item {
            display: flex;
            justify-content: space-between;
            padding: 6px 0;
            border-bottom: 1px solid #f0f4f8;
        }
        .stat-item:last-child {
            border-bottom: none;
        }
        .stat-item .label {
            color: #6c757d;
            font-size: 0.78rem;
            font-family: 'Cambria', Georgia, serif;
        }
        .stat-item .value {
            font-weight: 600;
            color: #000000;
            font-size: 0.82rem;
            font-family: 'Cambria', Georgia, serif;
        }
        .stat-item .value .badge {
            font-size: 0.65rem;
            padding: 2px 10px;
            border-radius: 10px;
        }
        
        .quick-actions {
            display: grid;
            gap: 6px;
        }
        .quick-actions .btn {
            font-size: 0.78rem;
            padding: 5px 12px;
        }
        
        /* ============================================
           RESPONSIVE
           ============================================ */
        
        /* Tablet - Hide Sidebar */
        @media (max-width: 991.98px) {
            .main-content {
                margin-left: 0 !important;
                max-width: 100% !important;
                padding: 12px 14px 16px;
            }
            .form-grid {
                grid-template-columns: 1fr;
                gap: 12px;
            }
            .page-header h1 {
                font-size: 1.1rem;
            }
            .page-header .btn-group-header .btn {
                font-size: 0.7rem;
                padding: 4px 10px;
            }
        }
        
        /* Mobile */
        @media (max-width: 575.98px) {
            .main-content {
                padding: 10px 8px 14px;
            }
            .page-header {
                flex-direction: column;
                align-items: flex-start;
                gap: 8px;
                padding-bottom: 10px;
                margin-bottom: 12px;
            }
            .page-header h1 {
                font-size: 1rem;
            }
            .page-header h1 i {
                font-size: 0.9rem;
            }
            .page-header .btn-group-header {
                width: 100%;
            }
            .page-header .btn-group-header .btn {
                font-size: 0.68rem;
                padding: 4px 10px;
                flex: 1;
                text-align: center;
            }
            .form-card .card-header {
                font-size: 0.78rem;
                padding: 8px 10px;
            }
            .form-card .card-body {
                padding: 12px;
            }
            .form-section {
                padding: 10px 12px;
                margin-bottom: 10px;
            }
            .form-section .section-title {
                font-size: 0.72rem;
                margin-bottom: 10px;
            }
            .form-label {
                font-size: 0.75rem;
            }
            .form-control, .form-select {
                font-size: 0.82rem;
                padding: 5px 10px;
            }
            .btn {
                font-size: 0.75rem;
                padding: 4px 12px;
                width: 100%;
                margin-top: 4px;
            }
            .file-info {
                font-size: 0.7rem;
                padding: 6px 10px;
            }
            .stat-item .label {
                font-size: 0.72rem;
            }
            .stat-item .value {
                font-size: 0.75rem;
            }
            .quick-actions .btn {
                font-size: 0.72rem;
                padding: 4px 10px;
            }
            .d-flex.justify-content-between {
                flex-direction: column;
                gap: 8px;
            }
            .d-flex.justify-content-between .d-flex {
                flex-wrap: wrap;
                gap: 4px;
            }
            .d-flex.justify-content-between .d-flex .btn {
                flex: 1;
                min-width: 80px;
            }
        }
        
        /* Extra Small */
        @media (max-width: 400px) {
            .main-content {
                padding: 8px 4px 10px;
            }
            .page-header h1 {
                font-size: 0.9rem;
            }
            .form-card .card-body {
                padding: 10px;
            }
            .form-section {
                padding: 8px 10px;
            }
            .form-control, .form-select {
                font-size: 0.78rem;
                padding: 4px 8px;
            }
            .form-label {
                font-size: 0.7rem;
            }
            .btn {
                font-size: 0.7rem;
                padding: 3px 10px;
            }
            .stat-item .label {
                font-size: 0.68rem;
            }
            .stat-item .value {
                font-size: 0.7rem;
            }
            .page-header .btn-group-header .btn {
                font-size: 0.62rem;
                padding: 3px 8px;
            }
        }
        
        /* ============================================
           DARK MODE OVERRIDE - Keep white
           ============================================ */
        @media (prefers-color-scheme: dark) {
            body {
                background: #ffffff !important;
            }
            .main-content {
                background: #ffffff !important;
            }
            .form-card {
                background: #f8f9fa !important;
                border-color: #eef1f5 !important;
            }
            .form-card .card-header {
                background: #f8f9fa !important;
                border-bottom-color: #eef1f5 !important;
                color: #000000 !important;
            }
            .form-card .card-body {
                background: #f8f9fa !important;
            }
            .form-section {
                background: #ffffff !important;
                border-color: #eef1f5 !important;
            }
            .form-section .section-title {
                color: #198754 !important;
            }
            .form-label {
                color: #000000 !important;
            }
            .form-control, .form-select {
                background: #ffffff !important;
                border-color: #eef1f5 !important;
                color: #000000 !important;
            }
            .form-control:disabled {
                background: #f8f9fa !important;
                color: #6c757d !important;
            }
            .form-check-label {
                color: #000000 !important;
            }
            .file-info {
                background: #f8f9fa !important;
                color: #000000 !important;
            }
            .file-info strong {
                color: #198754 !important;
            }
            .stat-item {
                border-bottom-color: #f0f4f8 !important;
            }
            .stat-item .label {
                color: #6c757d !important;
            }
            .stat-item .value {
                color: #000000 !important;
            }
            .page-header {
                border-bottom-color: #eef1f5 !important;
            }
            .page-header h1 {
                color: #000000 !important;
            }
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
                        <i class="fas fa-newspaper"></i> Edit Journal
                    </h1>
                    <div class="btn-group-header">
                        <a href="/admin/manage_journals.php" class="btn btn-secondary">
                            <i class="fas fa-arrow-left"></i> Back
                        </a>
                        <a href="/admin/manage_journals.php" class="btn btn-outline-success">
                            <i class="fas fa-list"></i> All Journals
                        </a>
                    </div>
                </div>
                
                <!-- Alert Messages -->
                <?php if ($success): ?>
                    <div class="alert alert-success alert-dismissible fade show" style="border-radius: 6px; font-family: 'Cambria', Georgia, serif; font-size: 0.85rem;">
                        <i class="fas fa-check-circle"></i> <?php echo $success; ?>
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                <?php endif; ?>
                <?php if ($error): ?>
                    <div class="alert alert-danger alert-dismissible fade show" style="border-radius: 6px; font-family: 'Cambria', Georgia, serif; font-size: 0.85rem;">
                        <i class="fas fa-exclamation-circle"></i> <?php echo $error; ?>
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                <?php endif; ?>
                
                <!-- Form Grid -->
                <div class="form-grid">
                    
                    <!-- ============================================
                    LEFT COLUMN - EDIT FORM
                    ============================================ -->
                    <div>
                        <div class="form-card">
                            <div class="card-header">
                                <i class="fas fa-edit"></i> Journal Information
                            </div>
                            <div class="card-body">
                                <form method="POST" action="" enctype="multipart/form-data">
                                    <!-- Article Details -->
                                    <div class="form-section">
                                        <div class="section-title"><i class="fas fa-info-circle"></i> Article Details</div>
                                        <div class="row">
                                            <div class="col-md-6 mb-3">
                                                <label class="form-label">Article Title <span class="text-danger">*</span></label>
                                                <input type="text" class="form-control" name="title" 
                                                       value="<?php echo htmlspecialchars($journal['title']); ?>" required>
                                            </div>
                                            <div class="col-md-6 mb-3">
                                                <label class="form-label">Journal Name <span class="text-danger">*</span></label>
                                                <input type="text" class="form-control" name="journal_name" 
                                                       value="<?php echo htmlspecialchars($journal['journal_name']); ?>" required>
                                            </div>
                                            <div class="col-md-6 mb-3">
                                                <label class="form-label">Specialty <span class="text-danger">*</span></label>
                                                <select class="form-select" name="specialty_id" required>
                                                    <option value="">Select Specialty</option>
                                                    <?php foreach ($specialties as $specialty): ?>
                                                    <option value="<?php echo $specialty['id']; ?>" 
                                                            <?php echo $journal['specialty_id'] == $specialty['id'] ? 'selected' : ''; ?>>
                                                        <?php echo htmlspecialchars($specialty['name']); ?>
                                                    </option>
                                                    <?php endforeach; ?>
                                                </select>
                                            </div>
                                            <div class="col-md-6 mb-3">
                                                <label class="form-label">Publication Date</label>
                                                <input type="date" class="form-control" name="date" 
                                                       value="<?php echo $journal['date']; ?>">
                                            </div>
                                        </div>
                                    </div>
                                    
                                    <!-- Publication Details -->
                                    <div class="form-section">
                                        <div class="section-title"><i class="fas fa-book"></i> Publication Details</div>
                                        <div class="row">
                                            <div class="col-md-4 mb-3">
                                                <label class="form-label">Volume</label>
                                                <input type="text" class="form-control" name="volume" 
                                                       value="<?php echo htmlspecialchars($journal['volume'] ?? ''); ?>">
                                            </div>
                                            <div class="col-md-4 mb-3">
                                                <label class="form-label">Issue</label>
                                                <input type="text" class="form-control" name="issue" 
                                                       value="<?php echo htmlspecialchars($journal['issue'] ?? ''); ?>">
                                            </div>
                                            <div class="col-md-4 mb-3">
                                                <label class="form-label">Pages</label>
                                                <input type="text" class="form-control" name="pages" 
                                                       value="<?php echo htmlspecialchars($journal['pages'] ?? ''); ?>">
                                            </div>
                                        </div>
                                    </div>
                                    
                                    <!-- DOI & Abstract -->
                                    <div class="form-section">
                                        <div class="section-title"><i class="fas fa-link"></i> DOI & Abstract</div>
                                        <div class="row">
                                            <div class="col-md-6 mb-3">
                                                <label class="form-label">DOI</label>
                                                <input type="text" class="form-control" name="doi" 
                                                       value="<?php echo htmlspecialchars($journal['doi'] ?? ''); ?>">
                                            </div>
                                            <div class="col-12 mb-3">
                                                <label class="form-label">Abstract</label>
                                                <textarea class="form-control" name="abstract" rows="4"><?php echo htmlspecialchars($journal['abstract'] ?? ''); ?></textarea>
                                            </div>
                                        </div>
                                    </div>
                                    
                                    <!-- File Upload & Settings -->
                                    <div class="form-section">
                                        <div class="section-title"><i class="fas fa-file-pdf"></i> File & Settings</div>
                                        <div class="row">
                                            <div class="col-md-6 mb-3">
                                                <label class="form-label">Journal PDF</label>
                                                <input type="file" class="form-control" name="journal_file" accept=".pdf">
                                                <?php if ($journal['file_path']): ?>
                                                <div class="file-info mt-2">
                                                    <i class="fas fa-file-pdf" style="color: #dc3545;"></i> 
                                                    Current: <strong><?php echo htmlspecialchars($journal['file_path']); ?></strong>
                                                    <br><small>Leave empty to keep current file</small>
                                                </div>
                                                <?php endif; ?>
                                            </div>
                                            <div class="col-md-6 mb-3">
                                                <div class="form-check">
                                                    <input type="checkbox" class="form-check-input" id="is_watermarked" name="is_watermarked" 
                                                           <?php echo $journal['is_watermarked'] ? 'checked' : ''; ?>>
                                                    <label class="form-check-label" for="is_watermarked">
                                                        <i class="fas fa-water"></i> Add Watermark (DRM Protection)
                                                    </label>
                                                </div>
                                                <div class="mt-3">
                                                    <label class="form-label">Status</label>
                                                    <select class="form-select" name="status">
                                                        <option value="pending" <?php echo $journal['status'] == 'pending' ? 'selected' : ''; ?>>Pending</option>
                                                        <option value="approved" <?php echo $journal['status'] == 'approved' ? 'selected' : ''; ?>>Approved</option>
                                                        <option value="rejected" <?php echo $journal['status'] == 'rejected' ? 'selected' : ''; ?>>Rejected</option>
                                                    </select>
                                                    <small class="text-muted" style="font-family: 'Cambria', Georgia, serif; font-size: 0.65rem;">Select the publication status</small>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    
                                    <!-- Form Actions -->
                                    <div class="d-flex justify-content-between align-items-center flex-wrap" style="gap: 8px; margin-top: 4px;">
                                        <div class="d-flex gap-2">
                                            <button type="submit" class="btn btn-success">
                                                <i class="fas fa-save"></i> Update Journal
                                            </button>
                                            <a href="/admin/manage_journals.php" class="btn btn-secondary">Cancel</a>
                                        </div>
                                        <div>
                                            <span class="badge bg-info" style="font-size: 0.7rem; padding: 4px 12px;">Views: <?php echo $journal['view_count']; ?></span>
                                            <span class="badge bg-success" style="font-size: 0.7rem; padding: 4px 12px;">Downloads: <?php echo $journal['download_count']; ?></span>
                                            <span class="badge bg-secondary" style="font-size: 0.7rem; padding: 4px 12px;">ID: #<?php echo $journal['id']; ?></span>
                                        </div>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                    
                    <!-- ============================================
                    RIGHT COLUMN - STATS & QUICK ACTIONS
                    ============================================ -->
                    <div>
                        <!-- Journal Statistics -->
                        <div class="form-card">
                            <div class="card-header">
                                <i class="fas fa-chart-bar"></i> Journal Statistics
                            </div>
                            <div class="card-body">
                                <div class="stat-item">
                                    <span class="label">Status</span>
                                    <span class="value">
                                        <span class="badge bg-<?php echo $journal['status'] == 'approved' ? 'success' : ($journal['status'] == 'pending' ? 'warning' : 'danger'); ?>" style="font-size: 0.7rem;">
                                            <?php echo ucfirst($journal['status']); ?>
                                        </span>
                                    </span>
                                </div>
                                <div class="stat-item">
                                    <span class="label">Uploaded</span>
                                    <span class="value"><?php echo date('F d, Y', strtotime($journal['created_at'])); ?></span>
                                </div>
                                <div class="stat-item">
                                    <span class="label">Last Updated</span>
                                    <span class="value"><?php echo $journal['updated_at'] ? date('F d, Y', strtotime($journal['updated_at'])) : 'Never'; ?></span>
                                </div>
                                <div class="stat-item">
                                    <span class="label"><i class="fas fa-eye"></i> Total Views</span>
                                    <span class="value"><?php echo number_format($journal['view_count']); ?></span>
                                </div>
                                <div class="stat-item">
                                    <span class="label"><i class="fas fa-download"></i> Total Downloads</span>
                                    <span class="value"><?php echo number_format($journal['download_count']); ?></span>
                                </div>
                                <div class="stat-item">
                                    <span class="label"><i class="fas fa-water"></i> Watermark</span>
                                    <span class="value"><?php echo $journal['is_watermarked'] ? '<span style="color: #198754;">Enabled</span>' : '<span style="color: #6c757d;">Disabled</span>'; ?></span>
                                </div>
                                <?php if ($journal['doi']): ?>
                                <div class="stat-item">
                                    <span class="label"><i class="fas fa-link"></i> DOI</span>
                                    <span class="value" style="font-size: 0.7rem;"><code><?php echo htmlspecialchars($journal['doi']); ?></code></span>
                                </div>
                                <?php endif; ?>
                                <div class="stat-item">
                                    <span class="label"><i class="fas fa-file-pdf"></i> File Size</span>
                                    <span class="value">
                                        <?php 
                                        if ($journal['file_path'] && file_exists(JOURNAL_UPLOAD_PATH . $journal['file_path'])) {
                                            $size = filesize(JOURNAL_UPLOAD_PATH . $journal['file_path']);
                                            echo formatFileSize($size);
                                        } else {
                                            echo 'N/A';
                                        }
                                        ?>
                                    </span>
                                </div>
                            </div>
                        </div>
                        
                        <!-- Quick Actions -->
                        <div class="form-card" style="margin-top: 12px;">
                            <div class="card-header">
                                <i class="fas fa-link"></i> Quick Actions
                            </div>
                            <div class="card-body">
                                <div class="quick-actions">
                                    <a href="/doctor/view-journal/<?php echo $journal['id']; ?>" target="_blank" class="btn btn-outline-success">
                                        <i class="fas fa-eye"></i> View Journal
                                    </a>
                                    <a href="/doctor/read-journal/<?php echo $journal['id']; ?>" target="_blank" class="btn btn-outline-primary">
                                        <i class="fas fa-book-open"></i> Open Reader
                                    </a>
                                    <?php if ($journal['file_path']): ?>
                                    <a href="/uploads/journals/<?php echo $journal['file_path']; ?>" target="_blank" class="btn btn-outline-secondary">
                                        <i class="fas fa-file-pdf"></i> View PDF
                                    </a>
                                    <?php endif; ?>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </main>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>