# Corporate Vendor Management System

## Overview

This project is a full-stack web application designed to streamline corporate vendor management processes. It allows organizations to manage vendor relationships, track contracts, monitor budgets, process purchase orders, evaluate vendor performance, and ensure compliance.

The system was developed collaboratively by **Hussain Ahmad** (i22-1374) ) as part of a project 

## Features

*   **Vendor Registration and Management:**
    *   Vendors can register, log in, and manage their profiles.
    *   Admin verification of vendors before contract assignment.
*   **Contract Lifecycle Management:**
    *   Create, manage, and track contracts with vendors.
    *   Define contract terms, start/end dates, and renewal dates.
    *   Automated contract status updates (Active, Expired, Pending, Renewed).
*   **Purchase Order Creation and Tracking:**
    *   Create and track purchase orders associated with contracts.
    *   Manage purchase order statuses (Pending, Completed, Cancelled, In Progress).
    *   Approval workflow for purchase orders.
*   **Budget Tracking and Management:**
    *   Allocate budgets to departments.
    *   Track expenditures against allocated budgets in real time.
    *   Alerts for potential budget overspending.
*   **Vendor Performance Tracking:**
    *   Evaluate vendors based on service quality, timeliness, and pricing.
    *   Store ratings and feedback for each vendor.
*   **Compliance and Auditing:**
    *   Conduct audits to ensure vendor compliance with company policies and legal standards.
    *   Track audit dates, results, and comments.
*   **Task Allocation:**
    *   Assign and track procurement-related tasks to users.
    *   Set task deadlines and priorities.
*   **Notifications:**
    *   Automatic alerts for contract renewals, budget deviations, task assignments, and other critical events.
*   **Role-Based Access Control (RBAC):**
    *   Different user roles (Admin, Procurement Manager, Department Head, Vendor) with specific permissions.
*   **Reporting:**
    *   Generate reports on vendor performance, contract status, and budget utilization.

## Technologies Used

*   **Frontend:**
    *   HTML
    *   CSS (with Material Design principles)
    *   JavaScript
    *   EJS (Embedded JavaScript Templating)
*   **Backend:**
    *   Node.js
    *   Express.js
*   **Database:**
    *   MySQL
*   **Security:**
    *   Bcrypt for password hashing
*   **Development Tools:**
    *   Git for version control
    *   GitHub for code hosting

## Project Structure
DB_PROJECT/
├── config/              # Database connection configuration
│   └── db.js
├── controllers/         # Business logic for each entity
│   ├── authController.js
│   ├── budgetsController.js
│   ├── complianceAuditsController.js
│   ├── contractsController.js
│   ├── notificationsController.js
│   ├── purchaseOrdersController.js
│   ├── tasksController.js
│   └── vendorsController.js
├── middleware/          # Authentication and validation middleware
│   ├── authMiddleware.js
│   └── validation.js
├── models/              # Database interaction logic for each entity
│   ├── authRoutes.js
│   ├── budgetModel.js
│   ├── complianceAuditModel.js
│   ├── contractModel.js
│   ├── notificationModel.js
│   ├── purchaseOrderModel.js
│   ├── taskModel.js
│   ├── userModel.js
│   └── vendorModel.js
├── node_modules/        # Project dependencies
├── public/              # Static assets (CSS, images, etc.)
│   └── styles.css
├── routes/              # API route definitions
│   ├── auth.js
│   ├── budgets.js
│   ├── complianceAudits.js
│   ├── contracts.js
│   ├── dashboard.js
│   ├── notifications.js
│   ├── purchase-orders.js
│   ├── tasks.js
│   └── vendors.js
├── views/               # EJS templates for rendering dynamic content
│   ├── 404.ejs
│   ├── 500.ejs
│   ├── budgets.ejs
│   ├── complianceAudits.ejs
│   ├── contracts.ejs
│   ├── dashboard.ejs
│   ├── index.ejs
│   ├── login.ejs
│   ├── notifications.ejs
│   ├── purchase-orders.ejs
│   ├── register.ejs
│   ├── taskDetail.ejs
│   └── tasks.ejs
├── .env                 # Environment variables
├── app.js               # Main application file
├── package.json         # Project metadata and dependencies
└── package-lock.json    # Detailed dependency tree

## Database Schema

The database schema is designed using an Entity-Relationship Diagram (ERD) and implemented in MySQL. Key tables include:

*   `Vendor`
*   `Contract`
*   `Department`
*   `PurchaseOrder`
*   `Performance`
*   `Budget`
*   `User`
*   `Notification`
*   `Task`
*   `ComplianceAudit`



## Getting Started

1.  **Clone the repository:**

    ```bash
    git clone  https://github.com/Striker6674/Corporate-Vendor-Management-System-/edit/main/README.md
    ```

2.  **Install dependencies:**

    ```bash
    cd Corporate-Vendor-Management-System-
    npm install
    ```

3.  **Set up the database:**
    *   Create a MySQL database named `Corporate_vendor_managment_system`.
    *   Import the database schema (you'll likely need to create an SQL file from your database design - if you used a tool like MySQL Workbench, it can generate this for you).

4.  **Configure environment variables:**
    *   Create a `.env` file in the root directory.
    *   Add the following environment variables, replacing the placeholders with your actual database credentials:

    ```
    DB_HOST=your_database_host
    DB_USER=your_database_user
    DB_PASSWORD=your_database_password
    DB_NAME=Corporate_vendor_managment_system
    ```

5.  **Run the application:**

    ```bash
    node app.js
    ```

6.  **Access the application in your browser:**
    *   Open `http://localhost:3000` (or the port specified in your `app.js` file).

## Assumptions

*   **User Authentication:** Passwords are hashed using bcrypt.
*   **Role-Based Access:** Users have roles (Admin, Procurement Manager, Vendor) with specific permissions.
*   **Vendor Compliance:** Vendors upload compliance certificates during registration, required for contracts.
*   **Budget Management:** Each department has a single budget record, updated in real-time.
*   **Notifications:** Managed through the `Notification` table, displayed on the user dashboard.
*   **Date Formats:** Dates are stored in ISO 8601 format (YYYY-MM-DD).
*   **Contract Lifecycle:** Contracts have statuses (Active, Expired, Pending, Renewed), updated automatically.
*   **Purchase Orders:** Orders have statuses (Pending, Completed, Cancelled, In Progress), with an approval workflow.
*   **Task Management:** Tasks have deadlines and priorities, tracked by the system.
*   **Data Integrity:** Foreign key constraints and database transactions ensure data consistency.
*   **Data Privacy:** Adheres to data privacy regulations (e.g., GDPR).
*   **Reporting:** Customizable reports can be generated and exported.

## Contributing

Contributions are welcome! Please follow these guidelines:

1.  Fork the repository.
2.  Create a new branch for your feature or bug fix.
3.  Make your changes and commit them with clear messages.
4.  Push your branch to your forked repository.
5.  Submit a pull request to the main repository.

## License

This project is licensed under the [MIT License](LICENSE) - see the LICENSE file for details. (You'll need to create a LICENSE file and choose a license - MIT is a common choice for open-source projects).

## Contact

*   **Hussain Ahmad:** [i221374@nu.edu.pk]

## Acknowledgements

*   [MySQL Documentation](https://dev.mysql.com/doc/)
*   [Node.js Documentation](https://nodejs.org/en/docs/)
*   [Express.js Documentation](https://expressjs.com/)
*   [EJS Documentation](https://ejs.co/)
*   [Material Design Guidelines](https://material.io/design)
*   [Stack Overflow](https://stackoverflow.com/)
*   [GitHub Repositories](https://github.com/)
*   [ChatGPT](https://chat.openai.com/)
*   [Bcrypt.js Documentation](https://www.npmjs.com/package/bcryptjs)
