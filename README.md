# Keila's Bike Shop - E-Commerce System

A complete bike shop e-commerce platform with shopping cart, checkout, order management, and admin features.

## 🚀 Features

### Customer Features
- **Product Catalog** - Browse bikes by category (Mountain, Road, Hybrid, Electric, Kids, BMX)
- **Product Search & Filters** - Find bikes quickly with search and category filters
- **Product Details** - View detailed specifications, pricing, and stock availability
- **Shopping Cart** - Add items, update quantities, remove items
- **Secure Checkout** - Complete order process with shipping information
- **Order History** - View past orders and track status
- **User Authentication** - Secure login/signup with password hashing
- **Responsive Design** - Mobile-friendly interface

### Admin Features (Coming Soon)
- Product management (add/edit/delete)
- Order management and status updates
- Customer management
- Sales dashboard and analytics

## 📋 Prerequisites

- **XAMPP** (or similar stack with Apache, MySQL, PHP 7.4+)
- Web browser (Chrome, Firefox, Edge, etc.)

## 🛠️ Installation

### 1. Copy Files to XAMPP
```
Copy the project folder to:
C:\xampp\htdocs\keilasbikeshop\
```

### 2. Start XAMPP Services
- Open XAMPP Control Panel
- Start **Apache** and **MySQL**

### 3. Create Database

**Option A: Using phpMyAdmin**
1. Open http://localhost/phpmyadmin
2. Click "New" to create a database
3. Database name: `keilas_db`
4. Collation: `utf8mb4_unicode_ci`
5. Click "Create"
6. Click "Import" tab
7. Choose `setup.sql` file from project folder
8. Click "Go"

**Option B: Using MySQL Command Line (PowerShell)**
```powershell
# Navigate to project directory
cd C:\xampp\htdocs\keilasbikeshop\keilasbikeshop

# Create database and import schema
& 'C:\xampp\mysql\bin\mysql.exe' -u root -p -e "CREATE DATABASE keilas_db CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;"
& 'C:\xampp\mysql\bin\mysql.exe' -u root -p keilas_db < setup.sql
```

### 4. Access the Site
Open your browser and navigate to:
```
http://localhost/keilasbikeshop/keilasbikeshop/
```

## 📊 Database Schema

The system includes the following tables:

- **users** - Customer accounts and authentication
- **products** - Bike inventory with categories, pricing, specs
- **orders** - Customer orders with shipping details
- **order_items** - Individual items in each order
- **inquiries** - Contact form submissions

## 🔑 Default Accounts

After running `setup.sql`, you'll have these test accounts:

**Admin Account**
- Email: `admin@keilasbikes.com`
- Password: `admin123`

**Test Customer**
- Email: `juan@example.com`
- Password: `user123`

## 📁 Project Structure

```
keilasbikeshop/
├── index.php              # Homepage
├── shop.php               # Product catalog
├── product.php            # Product detail page
├── cart.php               # Shopping cart
├── checkout.php           # Checkout process
├── orders.php             # Order history
├── order-success.php      # Order confirmation
├── about.php              # About page
├── contact.php            # Contact form
├── login.php              # User login
├── signup.php             # User registration
├── dashboard.php          # User dashboard
├── logout.php             # Logout handler
├── navbar.php             # Reusable navigation bar
├── db.php                 # Database connection
├── cart_functions.php     # Shopping cart functions
├── setup.sql              # Database schema + sample data
├── style.css              # Main stylesheet
└── README.md              # This file
```

## 🎨 Key Pages

### 1. Homepage (`index.php`)
- Hero section with call-to-action
- Featured bikes showcase
- Gallery section
- About preview

### 2. Shop (`shop.php`)
- Category filters
- Search functionality
- Sorting options (price, name, featured, newest)
- Grid view of all products

### 3. Product Detail (`product.php`)
- Large product image
- Full specifications
- Quantity selector
- Add to cart button
- Related products suggestions

### 4. Shopping Cart (`cart.php`)
- Item list with images
- Update quantities
- Remove items
- Price calculations
- Proceed to checkout

### 5. Checkout (`checkout.php`)
- Shipping information form
- Payment method selection
- Order summary
- Place order

### 6. Orders (`orders.php`)
- Order history list
- Order status tracking
- View detailed order information

## 🛒 Shopping Cart System

The cart is session-based with the following functions:

- `add_to_cart($product_id, $quantity, $conn)` - Add item to cart
- `update_cart_quantity($product_id, $quantity, $conn)` - Update item quantity
- `remove_from_cart($product_id)` - Remove item
- `get_cart_total()` - Calculate total price
- `get_cart_count()` - Get total item count
- `clear_cart()` - Empty the cart

## 🎯 Navigation Features

- **Responsive navbar** with mobile hamburger menu
- **Dropdown menus** for Shop categories
- **Cart badge** showing item count
- **User dropdown** with dashboard/orders/profile links
- **Active page** highlighting

## 🔐 Security Features

- Password hashing using `password_hash()` and `password_verify()`
- Prepared statements to prevent SQL injection
- Session-based authentication
- Input sanitization with `htmlspecialchars()`
- CSRF protection (form-based)

## 📱 Responsive Design

- Desktop-first design with mobile breakpoints
- Touch-friendly navigation and buttons
- Optimized image loading
- Mobile menu with slide-in animation

## 🚧 Future Enhancements

- [ ] Admin panel for product/order management
- [ ] Product reviews and ratings
- [ ] Wishlist functionality
- [ ] Email notifications for orders
- [ ] Payment gateway integration (PayPal, Stripe, GCash)
- [ ] Advanced inventory management
- [ ] Sales reports and analytics
- [ ] Customer profiles with address book
- [ ] Coupon/discount code system

## 🐛 Troubleshooting

### Database Connection Errors
- Verify MySQL is running in XAMPP
- Check database name is `keilas_db`
- Default credentials: username `root`, no password

### Images Not Loading
- Ensure image files (bike1.jpg, bike2.jpg, etc.) are in the project root
- Check file names match exactly (case-sensitive on some systems)

### Session Issues
- Verify `session_start()` is called before output
- Check PHP session configuration in `php.ini`

### Cart Not Working
- Ensure cookies are enabled in browser
- Check `cart_functions.php` is included
- Verify products exist in database

## 📞 Support

For issues or questions:
- Email: info@keilasbikes.com
- Phone: +63 912 345 6789

## 📄 License

© 2025 Keila's Bikes. All rights reserved.

---

**Built with ❤️ for bike enthusiasts in the Philippines**
