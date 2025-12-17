<?php
require_once __DIR__ . '/db.php';

if (!isset($_SESSION['user'])) {
    header("Location: login.php");
    exit;
}

$user = $_SESSION['user'];

// Get user orders
$stmt = $conn->prepare("SELECT * FROM orders WHERE user_id = ? ORDER BY created_at DESC");
$stmt->bind_param("i", $user['id']);
$stmt->execute();
$orders = $stmt->get_result()->fetch_all(MYSQLI_ASSOC);

// Get order details if viewing specific order
$viewing_order = null;
$order_items = [];
$order_tracking = [];

if (isset($_GET['view'])) {
    $order_id = (int)$_GET['view'];
    $stmt = $conn->prepare("SELECT * FROM orders WHERE id = ? AND user_id = ?");
    $stmt->bind_param("ii", $order_id, $user['id']);
    $stmt->execute();
    $viewing_order = $stmt->get_result()->fetch_assoc();
    
    if ($viewing_order) {
        $stmt = $conn->prepare("SELECT * FROM order_items WHERE order_id = ?");
        $stmt->bind_param("i", $order_id);
        $stmt->execute();
        $order_items = $stmt->get_result()->fetch_all(MYSQLI_ASSOC);
    }
}

// Function to get status badge
function get_status_badge($status) {
    $badges = [
        'pending' => '<span class="status-badge pending">⏳ Pending</span>',
        'processing' => '<span class="status-badge processing">📦 Processing</span>',
        'shipped' => '<span class="status-badge shipped">🚚 Shipped</span>',
        'delivered' => '<span class="status-badge delivered">✓ Delivered</span>',
        'completed' => '<span class="status-badge completed">✅ Completed</span>',
        'cancelled' => '<span class="status-badge cancelled">✗ Cancelled</span>'
    ];
    return $badges[$status] ?? $status;
}

// Function to get order timeline based on status - EXACTLY LIKE IMAGE
function getOrderTimeline($order) {
    if (!$order) return [];
    
    $created_date = strtotime($order['created_at']);
    $status = $order['status'];
    
    // Calculate dates based on order status
    $today = strtotime('now');
    
    // For demonstration: Set realistic dates based on order creation and status
    $dates = [
        'completed' => $status === 'completed' ? date('F j, Y', $today) : 'Pending',
        'open_planet' => in_array($status, ['processing', 'shipped', 'delivered', 'completed']) ? 
                        date('F j, Y', strtotime('-2 days', $today)) : 'Pending',
        'open_final_rg' => in_array($status, ['processing', 'shipped', 'delivered', 'completed']) ? 
                          date('F j, Y', strtotime('-3 days', $today)) : 'Pending',
        'proposed_pending' => 'Pending',
        'relevant_pending' => 'Pending'
    ];
    
    // Define the exact timeline steps from your image
    $timeline = [
        [
            'title' => 'Pending',
            'date' => $dates['completed'],
            'status' => $status === 'completed' || $status === 'delivered' ? 'active' : 'inactive',
            'description' => 'Order has been successfully completed. All items delivered and confirmed.',
        ],
        [
            'title' => 'Processing',
            'date' => $dates['open_planet'],
            'status' => $status === 'completed' || $status === 'delivered' ? 'active' : 'inactive',
            'description' => 'Order opened for global processing and distribution network.',
        ],
        [
            'title' => 'Shipped',
            'date' => $dates['open_final_rg'],
            'status' => $status === 'completed' || $status === 'delivered' ? 'active' : 'inactive',
            'description' => 'Regulatory compliance review in progress. Final approval pending.',
        ],
        [
            'title' => 'Delivered',
            'date' => $dates['proposed_pending'],
            'status' => 'inactive',
            'description' => 'Proposed output documents preparation pending regulatory approval.',
        ],
        [
            'title' => 'Completed',
            'date' => $dates['relevant_pending'],
            'status' => 'inactive',
            'description' => 'Connecting with relevant stakeholders and partners.',
        ]
    ];
    
    return $timeline;
}

?>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width,initial-scale=1.0">
<title>My Orders | Keila's Bikes</title>
<link rel="stylesheet" href="style.css">
<link rel="stylesheet" href="orders.css">
<style>
/* Reset and Base Styles */
* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}

body {
    font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, sans-serif;
    line-height: 1.6;
    color: #333;
    background-color: #fff;
}

/* EXACT TIMELINE FROM IMAGE */
.order-status-timeline {
    background: #f8f9fa;
    padding: 30px 0;
    border-bottom: 1px solid #e0e6ed;
    margin-top: 0;
}

.timeline-container {
    max-width: 800px;
    margin: 0 auto;
    padding: 0 20px;
}

/* Header exactly like image */
.timeline-header {
    text-align: center;
    margin-bottom: 30px;
}

.store-name {
    font-size: 32px;
    font-weight: bold;
    color: #2c3e50;
    margin-bottom: 10px;
    letter-spacing: 0.5px;
}

.page-title {
    font-size: 24px;
    font-weight: 600;
    color: #1a1a1a;
    margin-bottom: 20px;
}

.order-id-badge {
    display: inline-block;
    background: #1a1a1a;
    color: white;
    padding: 8px 16px;
    border-radius: 4px;
    font-family: 'Courier New', monospace;
    font-size: 14px;
    font-weight: 500;
    margin-top: 10px;
}

/* Timeline Steps - Exact match to image */
.timeline-steps {
    display: flex;
    flex-direction: column;
    gap: 0;
    position: relative;
    padding-left: 30px;
    margin-bottom: 40px;
}

.timeline-step {
    position: relative;
    padding: 20px 0 20px 40px;
    min-height: 60px;
}

.timeline-step::before {
    content: '';
    position: absolute;
    left: 0;
    top: 24px;
    width: 16px;
    height: 16px;
    border-radius: 50%;
    border: 3px solid white;
    box-shadow: 0 0 0 2px #ddd;
    background: #fff;
    z-index: 2;
}

.timeline-step.active::before {
    background: #2ecc71;
    box-shadow: 0 0 0 2px #2ecc71;
}

.timeline-step.inactive::before {
    background: #fff;
    box-shadow: 0 0 0 2px #ddd;
}

.timeline-steps::after {
    content: '';
    position: absolute;
    left: 7px;
    top: 24px;
    bottom: 24px;
    width: 2px;
    background: #ddd;
    z-index: 1;
}

.step-title {
    font-size: 16px;
    font-weight: 600;
    color: #1a1a1a;
    margin-bottom: 4px;
}

.timeline-step.active .step-title {
    color: #2ecc71;
}

.timeline-step.inactive .step-title {
    color: #95a5a6;
}

.step-date {
    font-size: 14px;
    color: #666;
    font-weight: 400;
}

/* Status Details - Exact match to image */
.status-details {
    background: white;
    border-radius: 8px;
    padding: 25px;
    border: 1px solid #e0e6ed;
    box-shadow: 0 2px 4px rgba(0,0,0,0.05);
}

.status-details h3 {
    color: #1a1a1a;
    font-size: 18px;
    font-weight: 600;
    margin-bottom: 20px;
    padding-bottom: 10px;
    border-bottom: 2px solid #e0e6ed;
}

.status-details-list {
    list-style: none;
}

.status-detail-item {
    margin-bottom: 20px;
    padding-bottom: 20px;
    border-bottom: 1px solid #eee;
}

.status-detail-item:last-child {
    margin-bottom: 0;
    padding-bottom: 0;
    border-bottom: none;
}

.detail-title {
    font-size: 16px;
    font-weight: 600;
    color: #2c3e50;
    margin-bottom: 8px;
}

.detail-description {
    color: #666;
    font-size: 14px;
    line-height: 1.6;
}

/* Orders Section Styles */
.orders-section {
    max-width: 1200px;
    margin: 0 auto;
    padding: 20px;
}

.orders-section h1 {
    color: #2c3e50;
    font-size: 32px;
    margin-bottom: 30px;
    text-align: center;
}

.orders-list {
    display: flex;
    flex-direction: column;
    gap: 20px;
}

.order-card {
    background: white;
    border-radius: 10px;
    padding: 25px;
    box-shadow: 0 3px 10px rgba(0, 0, 0, 0.08);
    border: 1px solid #e0e6ed;
    transition: all 0.3s ease;
}

.order-card:hover {
    transform: translateY(-3px);
    box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
}

.order-header {
    display: flex;
    justify-content: space-between;
    align-items: flex-start;
    margin-bottom: 20px;
    padding-bottom: 15px;
    border-bottom: 1px solid #e0e6ed;
}

.order-header h3 {
    color: #2c3e50;
    font-size: 20px;
    margin-bottom: 5px;
}

.order-date {
    color: #7f8c8d;
    font-size: 14px;
}

.order-status .status-badge {
    padding: 6px 12px;
    border-radius: 20px;
    font-size: 14px;
    font-weight: 600;
}

.status-badge.pending {
    background: #fff3cd;
    color: #856404;
}

.status-badge.processing {
    background: #cce5ff;
    color: #004085;
}

.status-badge.shipped {
    background: #d4edda;
    color: #155724;
}

.status-badge.delivered, .status-badge.completed {
    background: #d1ecf1;
    color: #0c5460;
}

.status-badge.cancelled {
    background: #f8d7da;
    color: #721c24;
}

.order-body {
    display: flex;
    justify-content: space-between;
    align-items: center;
    flex-wrap: wrap;
    gap: 15px;
}

.order-info p {
    margin-bottom: 8px;
    font-size: 15px;
}

.order-info strong {
    color: #2c3e50;
}

.order-actions .btn {
    padding: 10px 20px;
    background: #3498db;
    color: white;
    border: none;
    border-radius: 5px;
    font-weight: 600;
    text-decoration: none;
    cursor: pointer;
    transition: background 0.3s ease;
}

.order-actions .btn:hover {
    background: #2980b9;
}

/* Empty orders state */
.empty-orders {
    text-align: center;
    padding: 60px 20px;
    background: white;
    border-radius: 10px;
    box-shadow: 0 3px 10px rgba(0, 0, 0, 0.08);
}

.empty-icon {
    font-size: 60px;
    margin-bottom: 20px;
}

.empty-orders h2 {
    color: #2c3e50;
    margin-bottom: 10px;
    font-size: 24px;
}

.empty-orders p {
    color: #7f8c8d;
    margin-bottom: 30px;
    font-size: 16px;
}

.btn-large {
    padding: 12px 30px;
    background: #2ecc71;
    color: white;
    border: none;
    border-radius: 5px;
    font-size: 16px;
    font-weight: 600;
    text-decoration: none;
    cursor: pointer;
    transition: background 0.3s ease;
}

.btn-large:hover {
    background: #27ae60;
}

/* Order Detail View */
.order-detail {
    background: white;
    border-radius: 10px;
    padding: 30px;
    box-shadow: 0 3px 10px rgba(0, 0, 0, 0.08);
    margin-top: 20px;
}

.back-link {
    display: inline-block;
    margin-bottom: 20px;
    color: #3498db;
    text-decoration: none;
    font-weight: 600;
    font-size: 16px;
}

.back-link:hover {
    text-decoration: underline;
}

.order-detail-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 30px;
    padding-bottom: 20px;
    border-bottom: 1px solid #e0e6ed;
}

.order-detail-header h2 {
    color: #2c3e50;
    font-size: 24px;
    margin-bottom: 5px;
}

.order-detail-header p {
    color: #7f8c8d;
    font-size: 14px;
}

/* Responsive Design */
@media (max-width: 768px) {
    .timeline-step {
        padding-left: 30px;
    }
    
    .timeline-step::before {
        left: -3px;
    }
    
    .timeline-steps::after {
        left: 4px;
    }
    
    .order-header {
        flex-direction: column;
        gap: 10px;
    }
    
    .order-body {
        flex-direction: column;
        align-items: flex-start;
        gap: 15px;
    }
    
    .timeline-container {
        padding: 0 15px;
    }
    
    .store-name {
        font-size: 28px;
    }
    
    .page-title {
        font-size: 20px;
    }
}

@media (max-width: 480px) {
    .store-name {
        font-size: 24px;
    }
    
    .page-title {
        font-size: 18px;
    }
    
    .order-id-badge {
        font-size: 12px;
        padding: 6px 12px;
    }
    
    .step-title {
        font-size: 14px;
    }
    
    .step-date {
        font-size: 12px;
    }
}
</style>
</head>
<body>

<?php require_once 'navbar.php'; ?>

<?php if ($viewing_order): ?>
<!-- ORDER STATUS TIMELINE - EXACTLY LIKE THE IMAGE -->
<section class="order-status-timeline">
    <div class="timeline-container">
        <!-- Header exactly like your image -->
        <div class="timeline-header">
            <div class="store-name">Keila's Bikes</div>
            <div class="page-title">Order Status Timeline</div>
            <div class="order-id-badge">
                ORDER ID <?php echo htmlspecialchars($viewing_order['order_number']); ?> | ORDER COMPLETED
            </div>
        </div>
        
        <!-- Timeline Steps - Vertical with dots on left -->
        <div class="timeline-steps">
            <?php 
            $timeline = getOrderTimeline($viewing_order);
            foreach ($timeline as $step): 
            ?>
            <div class="timeline-step <?php echo $step['status']; ?>">
                <div class="step-title"><?php echo htmlspecialchars($step['title']); ?></div>
                <div class="step-date"><?php echo htmlspecialchars($step['date']); ?></div>
            </div>
            <?php endforeach; ?>
        </div>
        
        <!-- Separator line (dashed in image) -->
        <div style="height: 1px; background: #e0e6ed; margin: 30px 0; border-bottom: 2px dashed #ddd;"></div>
        
        <!-- Status Details - Exactly like your image -->
        <div class="status-details">
            <h3>Status Details</h3>
            <ul class="status-details-list">
                <?php foreach ($timeline as $step): ?>
                <li class="status-detail-item">
                    <div class="detail-title"><?php echo htmlspecialchars($step['title']); ?></div>
                    <div class="detail-description">
                        <?php echo htmlspecialchars($step['description']); ?>
                    </div>
                </li>
                <?php endforeach; ?>
            </ul>
        </div>
    </div>
</section>
<?php endif; ?>

<!-- Orders Section -->
<section class="orders-section">
    <div class="container">
        <h1>My Orders</h1>
        
        <?php if (!$viewing_order): ?>
            <!-- Orders List -->
            <?php if (count($orders) > 0): ?>
                <div class="orders-list">
                    <?php foreach ($orders as $order): ?>
                        <div class="order-card">
                            <div class="order-header">
                                <div>
                                    <h3>Order <?= htmlspecialchars($order['order_number']) ?></h3>
                                    <p class="order-date">Placed on <?= date('F j, Y', strtotime($order['created_at'])) ?></p>
                                </div>
                                <div class="order-status">
                                    <?= get_status_badge($order['status']) ?>
                                </div>
                            </div>

                            <div class="order-body">
                                <div class="order-info">
                                    <p><strong>Total Amount:</strong> ₱<?= number_format($order['total_amount'], 2) ?></p>
                                    <p><strong>Payment Method:</strong> <?= strtoupper($order['payment_method']) ?></p>
                                    <p><strong>Shipping To:</strong> <?= htmlspecialchars($order['shipping_name']) ?></p>
                                </div>
                                <div class="order-actions">
                                    <a href="orders.php?view=<?= $order['id'] ?>" class="btn">View Order Timeline</a>
                                </div>
                            </div>
                        </div>
                    <?php endforeach; ?>
                </div>
            <?php else: ?>
                <div class="empty-orders">
                    <div class="empty-icon">📦</div>
                    <h2>No orders yet</h2>
                    <p>Start shopping and place your first order!</p>
                    <a href="shop.php" class="btn-large">Browse Shop</a>
                </div>
            <?php endif; ?>
        <?php else: ?>
            <!-- Order Detail View -->
            <div class="order-detail">
                <a href="orders.php" class="back-link">← Back to All Orders</a>

                <div class="order-detail-header">
                    <div>
                        <h2>Order <?= htmlspecialchars($viewing_order['order_number']) ?></h2>
                        <p>Placed on <?= date('F j, Y \a\t g:i A', strtotime($viewing_order['created_at'])) ?></p>
                    </div>
                    <?= get_status_badge($viewing_order['status']) ?>
                </div>

                <!-- Order Items -->
                <div style="margin-top: 30px;">
                    <h3 style="margin-bottom: 20px; color: #2c3e50;">Order Items</h3>
                    <?php if (!empty($order_items)): ?>
                        <div style="display: grid; gap: 15px;">
                            <?php foreach ($order_items as $item): ?>
                                <div style="display: flex; justify-content: space-between; padding: 15px; background: #f8f9fa; border-radius: 8px;">
                                    <div>
                                        <strong><?= htmlspecialchars($item['product_name']) ?></strong>
                                        <div style="color: #666; font-size: 14px;">Quantity: <?= $item['quantity'] ?></div>
                                    </div>
                                    <div>₱<?= number_format($item['price'], 2) ?></div>
                                </div>
                            <?php endforeach; ?>
                        </div>
                    <?php else: ?>
                        <p>No items found for this order.</p>
                    <?php endif; ?>
                </div>
                
                <!-- Shipping Information -->
                <div style="margin-top: 30px; padding: 20px; background: #f8f9fa; border-radius: 8px;">
                    <h4 style="margin-bottom: 15px; color: #2c3e50;">Shipping Information</h4>
                    <p><strong>Recipient:</strong> <?= htmlspecialchars($viewing_order['shipping_name']) ?></p>
                    <p><strong>Address:</strong> <?= htmlspecialchars($viewing_order['shipping_address']) ?></p>
                    <p><strong>Contact:</strong> <?= htmlspecialchars($viewing_order['shipping_phone']) ?></p>
                </div>
            </div>
        <?php endif; ?>
    </div>
</section>

<footer style="text-align: center; padding: 30px 20px; color: #7f8c8d; font-size: 14px; border-top: 1px solid #e0e6ed; margin-top: 40px;">
    <p>© <?= date('Y') ?> Keila's Bikes | Ride Strong, Ride Smart.</p>
</footer>

</body>
</html>