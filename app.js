const express = require('express');
const bodyParser = require('body-parser');
const dotenv = require('dotenv');
const path = require('path');
const session = require('express-session');
const helmet = require('helmet');
const rateLimit = require('express-rate-limit');
const compression = require('compression');
const morgan = require('morgan'); // For logging HTTP requests
const pool = require('./config/db'); // Import the MySQL connection pool

// Load environment variables
dotenv.config();

// Import route modules
const vendorRoutes = require('./routes/vendors');
const contractRoutes = require('./routes/contracts');
const purchaseOrderRoutes = require('./routes/purchase-orders');
const budgetRoutes = require('./routes/budgets');
const authRoutes = require('./routes/auth');
const dashboardRoutes = require('./routes/dashboard');
const taskRoutes = require('./routes/tasks'); // Newly added route for tasks
const notificationRoutes = require('./routes/notifications'); // Newly added route for notifications
const complianceAuditRoutes = require('./routes/complianceAudits'); // Newly added route for compliance audits
const homeRoutes = require('./routes/home');
const vendorPerformanceRoutes = require('./routes/vendorPerformance'); // Newly added route for vendor performance


const app = express();

// Middleware for HTTP request logging (useful for debugging)
if (process.env.NODE_ENV === 'development') {
  app.use(morgan('dev')); // Logs requests in the console
} else {
  app.use(morgan('combined')); // More detailed logs for production
}

// Middleware
app.use(bodyParser.urlencoded({ extended: false }));
app.use(bodyParser.json());
app.use(express.static(path.join(__dirname, 'public')));
app.set('view engine', 'ejs');

// Security Middleware
app.use(helmet()); // Adds various security headers
app.use(compression()); // Compresses response bodies for improved performance

// Rate Limiting Middleware
const limiter = rateLimit({
  windowMs: 15 * 60 * 1000, // 15 minutes
  max: 100, // Limit each IP to 100 requests per windowMs
  standardHeaders: true,
  legacyHeaders: false,
});
app.use(limiter);

// Session Middleware
app.use(
  session({
    secret: process.env.SESSION_SECRET || 'securekey',
    resave: false,
    saveUninitialized: false,
    cookie: {
      httpOnly: true, // Prevents JavaScript access to cookies
      secure: process.env.NODE_ENV === 'production', // Use secure cookies in production
      maxAge: 60 * 60 * 1000, // 1-hour expiration
    },
  })
);

// Set locals for views
app.use((req, res, next) => {
  res.locals.user = req.session.user || null; // Makes `user` accessible in views
  next();
});

// Database Middleware
app.use((req, res, next) => {
  req.db = pool; // Attach the database connection pool to `req` for use in routes
  next();
});

// Routes
app.use('/', homeRoutes);
app.use('/', dashboardRoutes);
app.use('/vendors', vendorRoutes);
app.use('/contracts', contractRoutes);
app.use('/purchase-orders', purchaseOrderRoutes);
app.use('/budgets', budgetRoutes);
app.use('/auth', authRoutes);
app.use('/tasks', taskRoutes); // New route for tasks
app.use('/notifications', notificationRoutes); // New route for notifications
app.use('/compliance-audits', complianceAuditRoutes); // New route for compliance audits
app.use('/vendor-performance', vendorPerformanceRoutes); // New route for vendor performance

// 404 Error Handling
app.use((req, res) => {
  res.status(404).render('404', { title: 'Page Not Found' });
});

// Global Error Handling
app.use((err, req, res, next) => {
  console.error(err.stack);
  res.status(500).render('500', {
    title: 'Server Error',
    message: 'Something went wrong! Please try again later.',
  });
});

// Graceful Shutdown for SIGINT and SIGTERM signals
process.on('SIGINT', () => {
  console.log('\nGracefully shutting down from SIGINT (Ctrl+C)');
  process.exit();
});

process.on('SIGTERM', () => {
  console.log('Gracefully shutting down from SIGTERM');
  process.exit();
});

// Start Server
const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
  console.log(`Server running on port ${PORT} in ${process.env.NODE_ENV || 'development'} mode`);
});
