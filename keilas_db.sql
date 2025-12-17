-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Dec 17, 2025 at 03:09 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `keilas_db`
--

-- --------------------------------------------------------

--
-- Table structure for table `inquiries`
--

CREATE TABLE `inquiries` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `subject` varchar(255) DEFAULT NULL,
  `message` text NOT NULL,
  `status` enum('new','read','replied') DEFAULT 'new',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `order_number` varchar(50) NOT NULL,
  `total_amount` decimal(10,2) NOT NULL,
  `status` enum('pending','processing','shipped','delivered','cancelled') DEFAULT 'pending',
  `shipping_name` varchar(255) NOT NULL,
  `shipping_email` varchar(255) NOT NULL,
  `shipping_phone` varchar(50) DEFAULT NULL,
  `shipping_address` text NOT NULL,
  `payment_method` varchar(50) DEFAULT 'cod',
  `payment_status` enum('pending','paid','failed') DEFAULT 'pending',
  `notes` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `orders`
--

INSERT INTO `orders` (`id`, `user_id`, `order_number`, `total_amount`, `status`, `shipping_name`, `shipping_email`, `shipping_phone`, `shipping_address`, `payment_method`, `payment_status`, `notes`, `created_at`, `updated_at`) VALUES
(1, 2, 'ORD-20251208-EFA914', 68200.00, 'pending', 'Juan Dela Cruz', 'juan@example.com', '0987654321', 'dito sa bahay', 'cod', 'pending', '', '2025-12-08 07:42:07', '2025-12-08 07:42:07'),
(2, 4, 'ORD-20251210-C4E404', 204200.00, 'pending', 'Carlo Maiso', 'carlomaiso6@gmail.com', '09764241241212', 'antipolo city', 'cod', 'pending', '', '2025-12-10 10:27:31', '2025-12-10 10:27:31'),
(3, 5, 'ORD-20251216-2F6664', 135200.00, 'pending', 'Carlo Maiso', 'drsbjcam23@gmail.com', '09764241241212', 'Antipolo City', 'cod', 'pending', '', '2025-12-16 10:32:26', '2025-12-16 10:32:26'),
(4, 5, 'ORD-20251217-A24112', 135200.00, 'pending', 'Carlo Maiso', 'drsbjcam23@gmail.com', 'e124123353464636', 'Antipolo City', 'cod', 'pending', '', '2025-12-17 06:44:53', '2025-12-17 06:44:53'),
(5, 5, 'ORD-20251217-A94269', 190200.00, 'pending', 'Carlo Maiso', 'drsbjcam23@gmail.com', '09499052929', 'asdasd', 'cod', 'pending', 'sadas', '2025-12-17 13:41:43', '2025-12-17 13:41:43');

-- --------------------------------------------------------

--
-- Table structure for table `order_items`
--

CREATE TABLE `order_items` (
  `id` int(11) NOT NULL,
  `order_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `product_name` varchar(255) NOT NULL,
  `product_price` decimal(10,2) NOT NULL,
  `quantity` int(11) NOT NULL,
  `subtotal` decimal(10,2) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `order_items`
--

INSERT INTO `order_items` (`id`, `order_id`, `product_id`, `product_name`, `product_price`, `quantity`, `subtotal`, `created_at`) VALUES
(1, 1, 1, 'Trek Mountain X Pro', 68000.00, 1, 68000.00, '2025-12-08 07:42:07'),
(2, 2, 1, 'Trek Mountain X Pro', 68000.00, 3, 204000.00, '2025-12-10 10:27:31'),
(3, 3, 2, 'Speedster Road Elite', 45000.00, 3, 135000.00, '2025-12-16 10:32:27'),
(4, 4, 2, 'Speedster Road Elite', 45000.00, 3, 135000.00, '2025-12-17 06:44:54'),
(5, 5, 34, 'E-Car 4 Wheels', 190000.00, 1, 190000.00, '2025-12-17 13:41:43');

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `slug` varchar(255) NOT NULL,
  `category` enum('mountain','road','hybrid','electric','kids','bmx') NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `description` text DEFAULT NULL,
  `specs` text DEFAULT NULL,
  `image` varchar(255) DEFAULT NULL,
  `image_gallery` text DEFAULT NULL,
  `stock` int(11) DEFAULT 0,
  `featured` tinyint(1) DEFAULT 0,
  `is_active` tinyint(1) DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`id`, `name`, `slug`, `category`, `price`, `description`, `specs`, `image`, `image_gallery`, `stock`, `featured`, `is_active`, `created_at`, `updated_at`) VALUES
(1, 'Trek Mountain X-Pro\r\n', 'trek-mountain-x-pro', 'mountain', 68000.00, 'Professional mountain bike built for extreme terrain and durability.', 'Frame: Aluminum Alloy 6061 T6\nBrakes: Hydraulic disc brakes\nWheels: 29\" double-wall rims\nGears: 21-speed Shimano', 'bike2.jpg', NULL, 11, 1, 1, '2025-12-08 07:40:09', '2025-12-17 07:44:21'),
(2, 'Speedster Road Elite', 'speedster-road-elite', 'road', 45000.00, 'Lightweight road bike designed for speed and long-distance comfort.', 'Frame: Carbon fiber composite\nBrakes: Alloy C-brakes\nWheels: 700c racing wheels\nGears: 18-speed Shimano', 'bike3.jpg', NULL, 4, 1, 1, '2025-12-08 07:40:09', '2025-12-17 06:44:54'),
(3, 'Urban Hybrid Commuter', 'urban-hybrid-commuter', 'hybrid', 32000.00, 'Perfect city bike combining comfort and performance for daily commuting.', 'Frame: Steel frame with comfort geometry\nBrakes: V-brakes front and rear\nWheels: 700c hybrid tires\nGears: 7-speed', 'bike4.jpg', NULL, 20, 0, 1, '2025-12-08 07:40:09', '2025-12-08 07:40:09'),
(4, 'Alpine Peak 3000', 'alpine-peak-3000', 'mountain', 85000.00, 'Premium mountain bike with advanced suspension and components.', 'Frame: Full carbon fiber\nSuspension: 120mm travel front and rear\nBrakes: Shimano hydraulic disc\nWheels: 27.5\" tubeless ready', 'bike2.jpg', NULL, 8, 1, 1, '2025-12-08 07:40:09', '2025-12-08 07:40:09'),
(5, 'Lightning Bolt Road', 'lightning-bolt-road', 'road', 55000.00, 'Aerodynamic road bike for competitive cyclists and enthusiasts.', 'Frame: Aero carbon layup\nBrakes: Dual-pivot caliper\nWheels: Deep-section 50mm\nGears: 22-speed Shimano 105', 'bike3.jpg', NULL, 12, 0, 1, '2025-12-08 07:40:09', '2025-12-08 07:40:09'),
(6, 'E-Rider Electric', 'e-rider-electric', 'electric', 95000.00, 'Electric-assist bike with powerful motor and long-range battery.', 'Motor: 250W mid-drive\nBattery: 48V 14Ah (60km range)\nBrakes: Hydraulic disc\nDisplay: LCD with speed/battery', 'bike1.jpg', NULL, 6, 1, 1, '2025-12-08 07:40:09', '2025-12-08 07:40:09'),
(7, 'Kids Explorer', 'kids-explorer', 'kids', 12000.00, 'Safe and fun bike designed specifically for young riders.', 'Frame: Lightweight aluminum\nWheels: 20\" with training wheels\nBrakes: Coaster brake + hand brake\nColors: Multiple options', 'bike4.jpg', NULL, 25, 0, 1, '2025-12-08 07:40:09', '2025-12-08 07:40:09'),
(8, 'BMX Street Pro', 'bmx-street-pro', 'bmx', 18000.00, 'Durable BMX bike built for tricks, jumps, and street riding.', 'Frame: CrMo steel\nWheels: 20\" with pegs\nBrakes: U-brake rear\nHandlebars: 4-piece bars', 'bike2.jpg', NULL, 15, 0, 1, '2025-12-08 07:40:09', '2025-12-08 07:40:09'),
(9, 'SK 2 Wheels', 'sk-2-wheels', '', 10500.00, 'SK 2 Wheel is a durable bicycle wheel designed for stable handling and consistent rolling on various road surfaces.', 'Feature	Specification\r\nWheel Diameter	700C (622 mm)\r\nRims	Alloy (double-wall)\r\nSpokes	Stainless steel, 32-hole\r\nHubs	Sealed bearing hubs\r\nTyre Compatibility	700x23C – 700x32C\r\nBrake Type	Rim brake compatible\r\nWeight	~1.5–2.0 kg / pair\r\nUse Case	Road, commuter, fitness', 'bike6.png', NULL, 3, 0, 1, '2025-12-17 07:48:00', '2025-12-17 08:00:29'),
(10, 'Wosu 2 Wheels', 'wosu-2-wheels', '', 13000.00, 'Wosu 2 Wheels are durable bicycle wheels designed for smooth rolling, stable handling, and reliable everyday performance.', 'Motor: 350 W brushless hub  \r\n\r\nBattery: 48 V 12 Ah or 48 V 20 Ah \r\n\r\n50 km per charge \r\n\r\nTop Speed: 35–40 km/h \r\n\r\nCharging Time: 6–12 hours', 'bike7.png', NULL, 12, 0, 1, '2025-12-17 08:05:39', '2025-12-17 08:08:07'),
(11, 'Warrior 2 Wheels', 'warrior-2-wheels', '', 32000.00, 'A rugged electric mountain bike built for daily riding and off‑road trails with fat tires and a strong battery.', 'Motor: ~500 W rear hub \r\n\r\nBattery: 48 V 15 Ah lithium‑ion \r\n\r\nRange: ~80–105 km (50+ miles) per charge under ideal conditions \r\n\r\nTop Speed: ~37 km/h (23 mph) \r\n\r\nTires: 26\" x 4\" fat tires for mixed terrain \r\n\r\nLoad Capacity: ~450 lbs (205 kg) \r\n\r\nCharging Time: ~4–5 hrs', 'bike8.png', NULL, 6, 0, 1, '2025-12-17 08:12:28', '2025-12-17 08:12:28'),
(12, 'Super 113B 2 Wheels', 'super-113b-2-wheels', '', 15000.00, 'A basic 2‑wheeled electric bike for short daily rides and errands with simple controls and pedal assist.', 'Motor: ~500 W brushless hub \r\n\r\nBattery: 48 V, 12 Ah – 20 Ah options \r\n\r\nRange: ~40–50 km per charge \r\n\r\nTop Speed: ~35–40 km/h \r\n\r\nBrakes: Drum brakes \r\n\r\nRiders: 1–2 persons', 'bike9.png', NULL, 4, 0, 1, '2025-12-17 08:23:29', '2025-12-17 08:23:29'),
(13, 'Super 131 2 Wheels', 'super-131-2-wheels', '', 27000.00, 'A powerful 2‑wheels electric bike/scooter style e‑ride with a high‑power motor and big battery for faster speeds and longer rides.', 'Motor: ~2000 W electric motor (rated/peak) \r\n\r\nBattery: 60 V 20 Ah \r\n\r\nTop Speed: ~60–65 km/h \r\n\r\nRange: ~50–60 km per charge \r\n\r\nBrakes: Front disc brake', 'bike10.png', NULL, 7, 0, 1, '2025-12-17 08:27:44', '2025-12-17 08:27:44'),
(14, 'Super 115 2 Wheels', 'super-115-2-wheels', '', 29500.00, 'A mid-range 2-wheeled electric scooter with a strong motor and large battery built for city rides with good speed and range.', 'Motor: 800 W (up to 2000 W in some variants)\r\n\r\nBattery: 60 V 20 Ah\r\n\r\nTop Speed: 50–60 km/h\r\n\r\nRange: 40–60 km per charge\r\n\r\nBrakes: Front disc, rear drum\r\n\r\nTires: Tubeless 3.0×10\r\n\r\nLoad Capacity: ~150 kg', 'bike11.png', NULL, 6, 0, 1, '2025-12-17 08:33:03', '2025-12-17 08:33:03'),
(15, 'Super 134 Fino Style', 'super-134-fino-style', '', 33000.00, 'A Fino-style electric scooter with vintage look and decent power for city cruising.', 'Motor: 800 W\r\n\r\nBattery: 60 V 20 Ah\r\n\r\nTop Speed: 35–45 km/h\r\n\r\nRange: 30–40 km per charge\r\n\r\nTires: 10″ × 3.0″ tubeless\r\n\r\nBrakes: Front disc / rear drum\r\n\r\nLoad Capacity: 100–150 kg', 'bike12.png', NULL, 2, 0, 1, '2025-12-17 10:53:18', '2025-12-17 10:53:18'),
(16, 'Super 135B Nmax', 'super-135b-nmax', '', 35000.00, 'A budget‑friendly 2‑wheeled electric bike with decent power and basic features for daily city or short‑distance use', 'Motor: ~1000–2000 W electric motor\r\n\r\nBattery: 60 V 20 Ah (typical)\r\n\r\nRange: ~30–50 km per charge\r\n\r\nTop Speed: ~40–55 km/h\r\n\r\nBrakes: Front hydraulic disc, rear drum\r\n\r\nTires: 10″ × 3.0″ tubeless\r\n\r\nLoad Capacity: ~150–250 kg', 'bike13.png', NULL, 3, 0, 1, '2025-12-17 11:15:21', '2025-12-17 11:15:21'),
(17, 'Motor Style MT120', 'motor-style-mt120', '', 32000.00, 'A compact and reliable hub motor made for daily city riding with smooth acceleration and low maintenance.', 'Motor Type: Brushless rear hub motor\r\n\r\nRated Power: 1200 W\r\n\r\nVoltage: 60 V\r\n\r\nTop Speed: up to 50 km/h\r\n\r\nTorque: High torque for uphill and load carrying\r\n\r\nCooling: Air-cooled', 'bike14.png', NULL, 2, 0, 1, '2025-12-17 11:30:22', '2025-12-17 11:30:22'),
(18, 'Primo 3 Wheels', 'primo-3-wheels', '', 33000.00, 'A stable 3-wheeled electric trike designed for daily city riding or short-distance hauling with good balance and easy handling.', 'Motor: 1200 W brushless hub motor\r\n\r\nBattery: 60 V 30 Ah lithium-ion\r\n\r\nTop Speed: ~35 km/h\r\n\r\nRange: ~50–70 km per charge\r\n\r\nWheels: 3 wheels (front 1 / rear 2)\r\n\r\nBrakes: Front disc, rear drum', 'bike15.png', NULL, 2, 0, 1, '2025-12-17 11:37:18', '2025-12-17 11:37:18'),
(19, 'Super 001C 3 Wheels', 'super-001c-3-wheels', '', 27000.00, 'A basic 3-wheeled electric trike built for family or light cargo use with simple controls and decent load capacity.', 'Motor: 600 W brushless hub motor\r\n\r\nBattery: 48 V 20 Ah\r\n\r\nTop Speed: ~25–30 km/h\r\n\r\nRange: ~20–30 km per charge\r\n\r\nBrakes: Front disc brake', 'bike16.png', NULL, 5, 0, 1, '2025-12-17 11:47:21', '2025-12-17 11:47:21'),
(20, 'Super 210A 3 Wheels', 'super-210a-3-wheels', '', 35000.00, 'A compact and reliable 3-wheeled electric trike made for city-to-short distance rides with good balance and cargo/passenger space.\r\n', 'Motor: 800 W brushless hub motor\r\nBattery: 48 V 25 Ah lithium-ion\r\n\r\nTop Speed: ~30–40 km/h\r\n\r\nRange: ~45–70 km per charge\r\n\r\nBrakes: Front disc, rear drum\r\n\r\nLoad Capacity: ~200–280 kg\r\n\r\nCharging Time: ~6–8 hrs\r\n\r\nFeatures: Reverse mode, digital display, signal lights', 'bike17.png', NULL, 7, 0, 1, '2025-12-17 12:00:40', '2025-12-17 12:00:40'),
(21, 'Super 301 3 Wheels', 'super-301-3-wheels', '', 50000.00, 'A sturdy 3-wheeled electric trike built for daily city use, short errands, and light cargo transport.', 'Motor: 1000 W brushless rear hub motor\r\n\r\nBattery: 60 V 30 Ah lithium-ion\r\n\r\nTop Speed: ~35–45 km/h\r\n\r\nRange: ~50–80 km per charge\r\n\r\nBrakes: Front disc, rear drum\r\n\r\nLoad Capacity: ~220–300 kg\r\n\r\nCharging Time: ~6–8 hrs\r\n\r\nFeatures: Reverse gear, digital display, LED lights', 'bike18.png', NULL, 2, 0, 1, '2025-12-17 12:33:19', '2025-12-17 12:35:57'),
(22, 'Luoda K8 3 Wheels', 'luoda-k8-3-wheels', '', 52000.00, 'A rugged 3-wheeled electric trike designed for daily city commuting or light hauling with strong motor and good load capacity.', 'Motor: 1500 W brushless rear hub motor\r\n\r\nBattery: 60 V 20 Ah lithium-ion\r\n\r\nTop Speed: ~35–45 km/h\r\n\r\nRange: ~45–70 km per charge\r\n\r\nBrakes: Front drum, rear drum\r\n\r\nLoad Capacity: ~350–400 kg\r\n\r\nTires: 3.00-10 tubeless style\r\n\r\nCharging Time: ~6–8 hrs\r\n\r\nFeatures: Reverse, LED lights, digital panel, signal lights', 'bike19.png', NULL, 2, 0, 1, '2025-12-17 12:43:23', '2025-12-17 12:43:23'),
(23, 'Antelope Cargo 3 Wheels', 'antelope-cargo-3-wheels', '', 57000.00, 'A sturdy 3‑wheeled electric cargo trike for daily deliveries, errands, or hauling small loads.', 'Motor: 1000 W brushless rear hub motor\r\n\r\nBattery: 60 V 50 Ah lithium‑ion\r\n\r\nTop Speed: ~35–40 km/h\r\n\r\nRange: ~50–80 km per charge\r\n\r\nBrakes: Front and rear drum brakes\r\n\r\nLoad Capacity: ~300–500 kg\r\n\r\nCharging Time: ~7–9 hrs\r\n\r\nWheels: 3 wheels (1 front / 2 rear)\r\n\r\nFeatures: Reverse mode, LED lights, digital display', 'bike20.png', NULL, 2, 0, 1, '2025-12-17 12:50:43', '2025-12-17 12:52:56'),
(24, 'Cargo 3 Wheels Stainless', 'cargo-3-wheels-stainless', '', 58000.00, 'A rugged stainless‑frame electric cargo tricycle built for hauling goods, deliveries, or utility use with stable three‑wheel balance and strong load capacity.', 'Motor: 1000–1500 W brushless motor\r\n\r\nBattery: 48 V–60 V, 20–45 Ah\r\n\r\nTop Speed: ~30–45 km/h\r\n\r\nRange: ~50–80 km per charge\r\n\r\nLoad Capacity: ~300–1000 kg\r\n\r\nFrame: Stainless or reinforced steel cargo chassis\r\n\r\nBrakes: Front and rear drum or disc brakes', 'bike21.png', NULL, 2, 0, 1, '2025-12-17 13:00:45', '2025-12-17 13:00:45'),
(25, 'Amore V2 4 Wheels', 'amore-v2-4-wheels', '', 75000.00, 'A compact 4‑wheeled electric vehicle made for short city trips, errands, and stable everyday use with easy handling and seating for two adults.', 'Motor: 1200 W brushless electric motor\r\n\r\nBattery: 60 V 45 Ah lithium‑ion\r\n\r\nTop Speed: ~40–45 km/h\r\n\r\nRange: ~50–80 km per charge\r\n\r\nSeats: 2 adults\r\n\r\nWheels: 4 wheels with tubeless tires\r\n\r\nBrakes: Front disc, rear drum\r\n\r\nCharging Time: ~8–10 hours\r\n\r\nLoad Capacity: ~300–350 kg', 'bike22.png', NULL, 7, 0, 1, '2025-12-17 13:04:13', '2025-12-17 13:04:13'),
(26, 'Maximus 4 Wheels', 'maximus-4-wheels', '', 65000.00, 'A 4‑wheeled utility terrain vehicle (UTV) built for off‑road and utility use, with a strong V‑twin engine, CVT transmission, and cargo bed.', 'Engine: V‑Twin 4‑Stroke, 800 cc EFI\r\n\r\nPower: ~44 kW\r\n\r\nTorque: ~73 N·m\r\n\r\nTransmission: CVT (L‑H‑N‑R‑P)\r\n\r\nSuspension: Independent double A‑arm front/rear\r\n\r\nBrakes: Disc brakes front & rear\r\n\r\nTires: 27×9‑14 (front), 27×11‑14 (rear)\r\n\r\nCargo Bed: ~220 lbs capacity\r\n\r\nSeating: 2 persons\r\n\r\nTowing Capacity: ~2200 lbs\r\n\r\nFuel Capacity: ~6.6 gallons\r\n\r\nGround Clearance: ~11 in\r\n\r\nWeight: ~656 kg curb', 'bike23.png', NULL, 14, 0, 1, '2025-12-17 13:08:19', '2025-12-17 13:08:19'),
(27, 'Mercedez Benz 4 Wheels', 'mercedez-benz-4-wheels', '', 87000.00, 'A premium e‑bike/motorbike styled with Mercedes‑Benz design cues, built for smooth city riding and high-end performance.', 'Motor: 500–1000 W brushless hub motor\r\n\r\nBattery: 48–60 V, 15–20 Ah lithium‑ion\r\n\r\nTop Speed: ~40–50 km/h\r\n\r\nRange: ~40–60 km per charge\r\n\r\nWheels: 2 (front/rear) tubeless tires\r\n\r\nBrakes: Front and rear disc\r\n\r\nLoad Capacity: ~120–150 kg\r\n\r\nCharging Time: ~4–6 hrs', 'bike24.png', NULL, 18, 0, 1, '2025-12-17 13:14:12', '2025-12-17 13:14:12'),
(28, 'Prado 4 Wheels', 'prado-4-wheels', '', 62000.00, 'A stable four‑wheeled electric bike designed for easy city cruising, family errands, and comfortable rides with added balance and safety.', 'Motor: 1000 W brushless motor\r\n\r\nBattery: 60 V 30 Ah lithium‑ion\r\n\r\nTop Speed: ~35–45 km/h\r\n\r\nRange: ~50–80 km per charge\r\n\r\nWheels: 4 tubeless tires\r\n\r\nBrakes: Front and rear disc brakes\r\n\r\nLoad Capacity: ~250–350 kg\r\n\r\nCharging Time: ~6–8 hrs\r\n\r\nFeatures: Digital display, LED lights, reverse mode', 'bike25.png', NULL, 12, 0, 1, '2025-12-17 13:17:44', '2025-12-17 13:17:44'),
(29, 'Unicorn 4 Wheels', 'unicorn-4-wheels', '', 87000.00, 'A fun and stable four‑wheeled electric bike with a unique design, built for safe cruising and easy handling around town.', 'Motor: 1000 W brushless electric motor\r\n\r\nBattery: 60 V 25 Ah lithium‑ion\r\n\r\nTop Speed: ~35–45 km/h\r\n\r\nRange: ~50–70 km per charge\r\n\r\nWheels: 4 tubeless tires\r\n\r\nBrakes: Front and rear disc brakes\r\n\r\nLoad Capacity: ~250 kg\r\n\r\nCharging Time: ~6–8 hrs\r\n\r\nFeatures: LED lights and digital display', 'bike26.jpg', NULL, 12, 0, 1, '2025-12-17 13:20:52', '2025-12-17 13:20:52'),
(30, 'Fury 4 Seaters', 'fury-4-seaters', '', 65000.00, 'A rugged four‑wheeled electric bike with seating for four people, made for group rides and stable family cruising.', 'Motor: 1500 W brushless electric motor\r\n\r\nBattery: 72 V 35 Ah lithium‑ion\r\n\r\nTop Speed: ~40–50 km/h\r\n\r\nRange: ~60–90 km per charge\r\n\r\nWheels: 4 tubeless tires\r\n\r\nBrakes: Front and rear disc brakes\r\n\r\nSeating Capacity: 4 persons\r\n\r\nLoad Capacity: ~400–500 kg\r\n\r\nCharging Time: ~8–10 hrs\r\n\r\nFeatures: Digital display, LED lights, reverse mode', 'bike27.png', NULL, 16, 0, 1, '2025-12-17 13:24:35', '2025-12-17 13:24:35'),
(31, 'Fury 6 Seaters', 'fury-6-seaters', '', 67000.00, 'A heavy‑duty electric bike with six seats, built for group rides, family transport, or passenger service with stable four‑wheel balance.', 'Motor: 2000 W brushless electric motor\r\n\r\nBattery: 72 V 45 Ah lithium‑ion\r\n\r\nTop Speed: ~40–55 km/h\r\n\r\nRange: ~60–100 km per charge\r\n\r\nWheels: 4 tubeless tires\r\n\r\nBrakes: Front and rear disc brakes\r\n\r\nSeating Capacity: 6 persons\r\n\r\nLoad Capacity: ~600–700 kg\r\n\r\nCharging Time: ~8–10 hrs\r\n\r\nFeatures: Digital display, LED lights, reverse mode', 'bike28.png', NULL, 12, 0, 1, '2025-12-17 13:27:42', '2025-12-17 13:27:42'),
(32, 'Fabiana 4 Wheels', 'fabiana-4-wheels', '', 63000.00, 'A sleek four‑wheeled electric bike designed for comfortable city cruising with balanced handling and modern features.', 'Motor: 1200 W brushless electric motor\r\n\r\nBattery: 60 V 30 Ah lithium‑ion\r\n\r\nTop Speed: ~40–50 km/h\r\n\r\nRange: ~50–80 km per charge\r\n\r\nWheels: 4 tubeless tires\r\n\r\nBrakes: Front and rear disc brakes\r\n\r\nLoad Capacity: ~300–350 kg\r\n\r\nCharging Time: ~6–8 hrs\r\n\r\nFeatures: LED lights, digital display, reverse mode', 'bike29.png', NULL, 12, 0, 1, '2025-12-17 13:31:05', '2025-12-17 13:31:05'),
(33, 'Super 401 4 Wheels', 'super-401-4-wheels', '', 57000.00, 'A stable four‑wheeled electric bike built for city cruising, errands, and everyday use with extra balance and comfort.', 'Motor: 1200 W brushless electric motor\r\n\r\nBattery: 60 V 30 Ah lithium‑ion\r\n\r\nTop Speed: ~40–50 km/h\r\n\r\nRange: ~50–80 km per charge\r\n\r\nWheels: 4 tubeless tires\r\n\r\nBrakes: Front and rear disc brakes\r\n\r\nLoad Capacity: ~300–400 kg\r\n\r\nCharging Time: ~6–8 hrs\r\n\r\nFeatures: Digital display, LED lights, reverse mode', 'bike30.png', NULL, 12, 0, 1, '2025-12-17 13:36:26', '2025-12-17 13:36:26'),
(34, 'E-Car 4 Wheels', 'ecar-4-wheels', '', 190000.00, 'A four‑wheeled electric car built for everyday driving with zero emissions and modern comfort features.', 'Motor: Electric motor (single or dual)\r\n\r\nBattery: ~40–80 kWh lithium‑ion pack\r\n\r\nTop Speed: ~130–180 km/h\r\n\r\nRange: ~200–400 km per charge\r\n\r\nSeating: 4–5 passengers\r\n\r\nBrakes: Front and rear disc brakes with ABS\r\n\r\nCharging: AC and DC fast charging support\r\n\r\nFeatures: Regenerative braking, digital display, safety systems', 'bike31.jpg', NULL, 4, 0, 1, '2025-12-17 13:38:55', '2025-12-17 13:41:43');

-- --------------------------------------------------------

--
-- Table structure for table `reviews`
--

CREATE TABLE `reviews` (
  `id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `rating` int(11) NOT NULL CHECK (`rating` >= 1 and `rating` <= 5),
  `review_text` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `phone` varchar(50) DEFAULT NULL,
  `address` text DEFAULT NULL,
  `is_admin` tinyint(1) DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `password`, `phone`, `address`, `is_admin`, `created_at`, `updated_at`) VALUES
(1, 'Admin', 'admin@keilasbikes.com', 'admin123', NULL, NULL, 1, '2025-12-08 07:40:09', '2025-12-08 07:40:09'),
(2, 'Juan Dela Cruz', 'juan@example.com', '$2y$10$qpmWb1he0e7AdcNBr7nLX.TfFz0YUaFVF56y6tc29CYjoE8aI5eaK', NULL, NULL, 0, '2025-12-08 07:40:09', '2025-12-08 07:40:46'),
(3, 'sodi', 'sodi@gmail.com', '$2y$10$iOp4bDQ6eu3mIvnRuTIHGu2THVYYiDI4WLyJe9R9kMyXIdCld.BtO', NULL, NULL, 0, '2025-12-10 09:14:05', '2025-12-10 09:14:05'),
(4, 'Carlo Maiso', 'carlomaiso6@gmail.com', '$2y$10$1eH14kswGryyX9Zox2UxmeQg9OzEFq4EVyKo09dxoS67hESKAG5ai', NULL, NULL, 0, '2025-12-10 09:26:22', '2025-12-10 09:26:22'),
(5, 'Carlo Maiso', 'drsbjcam23@gmail.com', '$2y$10$0X6C/mn5RxJD1j8qWVmkbe1tUpGgq9gRpgBW7DArYyH4KXBERKDMO', NULL, NULL, 0, '2025-12-16 10:31:30', '2025-12-16 10:31:30');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `inquiries`
--
ALTER TABLE `inquiries`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_status` (`status`);

--
-- Indexes for table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `order_number` (`order_number`),
  ADD KEY `idx_user` (`user_id`),
  ADD KEY `idx_status` (`status`),
  ADD KEY `idx_order_number` (`order_number`);

--
-- Indexes for table `order_items`
--
ALTER TABLE `order_items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `product_id` (`product_id`),
  ADD KEY `idx_order` (`order_id`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `slug` (`slug`),
  ADD KEY `idx_category` (`category`),
  ADD KEY `idx_featured` (`featured`),
  ADD KEY `idx_slug` (`slug`);

--
-- Indexes for table `reviews`
--
ALTER TABLE `reviews`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `idx_product` (`product_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `inquiries`
--
ALTER TABLE `inquiries`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `orders`
--
ALTER TABLE `orders`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `order_items`
--
ALTER TABLE `order_items`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=35;

--
-- AUTO_INCREMENT for table `reviews`
--
ALTER TABLE `reviews`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `orders`
--
ALTER TABLE `orders`
  ADD CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `order_items`
--
ALTER TABLE `order_items`
  ADD CONSTRAINT `order_items_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `order_items_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`);

--
-- Constraints for table `reviews`
--
ALTER TABLE `reviews`
  ADD CONSTRAINT `reviews_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `reviews_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
