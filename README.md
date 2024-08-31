
# Finance Tracker Application
This project is a comprehensive finance tracking application designed to manage personal and business expenses, incomes, and subscriptions. The application allows users to categorize transactions, track payment statuses, and adjust categories and statuses dynamically. Additionally, it supports tracking whether an expense is monthly or yearly, and provides clear, human-readable outputs for category and status fields. This README provides an overview of the project, its architecture, and the steps to set it up and run it.

1. Table of Contents
2. Introduction
3. Technologies Used
4. Project Architecture
5. Project directory structure
6. Logical Design
7. Business Process
8. Technical Design
9. Database Schema
10. API Endpoints
12. Setting Up the Project
12. Running the Application
13. Dockerization
14. Contributing
15. License

## Introduction
This project implements a finance tracking system where users can manage their income and expenses, organized by categories, payment statuses, and frequency (monthly or yearly). The application is designed as a microservices architecture with a robust backend and a dynamic frontend that communicates via RESTful APIs.

## Technologies Used
- **Backend Framework**: NestJS (with TypeScript)
- **Frontend Framework**: ReactJS (with TypeScript)
- **Database**: SQLite
- **Containerization**: Docker
- **API Design**: RESTful services
- **Version Control**: Git

## Project Architecture
This project follows a microservices architecture with a separate backend service for managing financial data and a frontend service for user interaction. The backend is designed as a RESTful API using NestJS, chosen for its scalability, modular architecture, and TypeScript support. The frontend is developed using ReactJS, a widely adopted library for building dynamic user interfaces.

- **Backend**: The backend service is built with NestJS, which allows for the creation of scalable and maintainable server-side applications. NestJS was selected due to its comprehensive support for TypeScript, strong module-based architecture, and built-in support for handling asynchronous operations. Java was not chosen due to the higher complexity and overhead it introduces, especially for a project of this scale where simplicity, rapid development, and easy deployment are priorities. NestJS is better suited for small to medium-sized applications where development speed and maintainability are key.

- **Frontend**: ReactJS is used for the frontend due to its component-based architecture, which facilitates the development of reusable UI components. React's popularity and robust ecosystem also contribute to its selection.

- **Database**: SQLite is used as the database due to its lightweight nature and ease of use. Although PostgreSQL offers more advanced features and scalability, SQLite is sufficient for this project’s expected workload. The choice of SQLite is justified by its support for SQL views, which allows for the creation of human-readable outputs by replacing IDs with corresponding text values from related tables. This feature is crucial for generating reports where users need to see descriptive category names instead of numeric IDs. The simplicity and portability of SQLite also make it an ideal choice for a project that prioritizes ease of deployment and maintenance.

- **Dockerization**: The application is containerized using Docker, allowing for easy deployment and environment consistency. The entire application can be built and run as a single Docker container.

## Project directory structure
The project is divided into four main directories: `backend`, `frontend`, `database`, and `resources`. Below is an overview of the directory structure and the purpose of each directory and key files.

## Directory structure of project

priceTag/
├── backend/
│   ├── src/
│   │   ├── app.module.ts
│   │   ├── main.ts
│   │   ├── transactions/
│   │   │   ├── transactions.controller.ts
│   │   │   ├── transactions.service.ts
│   │   │   ├── transactions.module.ts
│   │   │   ├── entities/
│   │   │   │   └── transaction.entity.ts
│   │   ├── categories/
│   │   │   ├── categories.controller.ts
│   │   │   ├── categories.service.ts
│   │   │   ├── categories.module.ts
│   │   │   ├── entities/
│   │   │   │   └── category.entity.ts
│   │   ├── transactionTypes/
│   │   │   ├── transactionTypes.controller.ts
│   │   │   ├── transactionTypes.service.ts
│   │   │   ├── transactionTypes.module.ts
│   │   │   ├── entities/
│   │   │   │   └── transactionType.entity.ts
│   │   ├── status/
│   │   │   ├── status.controller.ts
│   │   │   ├── status.service.ts
│   │   │   ├── status.module.ts
│   │   │   ├── entities/
│   │   │   │   └── status.entity.ts
│   ├── test/
│   │   ├── app.e2e-spec.ts
│   │   ├── jest-e2e.json
│   ├── nest-cli.json
│   ├── package.json
│   ├── tsconfig.json
│   ├── Dockerfile
│   └── .env
├── frontend/
│   ├── src/
│   │   ├── components/
│   │   │   ├── TransactionList.tsx
│   │   │   ├── AddTransactionForm.tsx
│   │   │   ├── CategoryList.tsx
│   │   ├── pages/
│   │   │   ├── HomePage.tsx
│   │   │   ├── CategoriesPage.tsx
│   │   │   ├── TransactionsPage.tsx
│   │   ├── App.tsx
│   │   ├── index.tsx
│   ├── public/
│   │   ├── index.html
│   │   ├── favicon.ico
│   ├── package.json
│   ├── tsconfig.json
│   ├── Dockerfile
│   └── .env
├── database/
│   ├── migrations/
│   │   ├── 001_initial_schema.sql
│   ├── seeds/
│   │   ├── seed_data.sql
│   ├── init_db.sql
│   └── Dockerfile
├── resources/
│   ├── mock_data/
│   │   ├── transactions.json
│   │   ├── categories.json
│   ├── assets/
│   │   ├── logo.png
│   └── README.md
├── docker-compose.yml
└── README.md

### Description of Directories and Files

#### `backend/`
- **src/**: Contains the source code for the backend application built with NestJS.
  - **app.module.ts**: The main module of the application.
  - **main.ts**: The entry point of the application that bootstraps the NestJS app.
  - **transactions/**, **categories/**, **transactionTypes/**, **status/**: Modules for each part of the application (transactions, categories, transaction types, statuses), each containing controller, service, module, and entity files.
- **test/**: Test files for end-to-end (e2e) testing.
- **nest-cli.json**: Configuration for NestJS CLI.
- **package.json**: Lists dependencies and scripts for the backend.
- **tsconfig.json**: TypeScript configuration for the backend.
- **Dockerfile**: Docker file to create an image for the backend.
- **.env**: Configuration file for environment variables.



#### `frontend/`
- **src/**: Contains the source code for the frontend application built with React.
  - **components/**: React components, such as the transaction list or add transaction form.
  - **pages/**: Various pages of the application, such as the homepage or transactions page.
  - **App.tsx**: The main component of the application.
  - **index.tsx**: The entry point of the application.
- **public/**: Publicly accessible files served by the web server (HTML, favicon).
- **package.json**: Lists dependencies and scripts for the frontend.
- **tsconfig.json**: TypeScript configuration for the frontend.
- **Dockerfile**: Docker file to create an image for the frontend.
- **.env**: Configuration file for environment variables.

#### `database/`
- **migrations/**: SQL scripts for database migration, such as the initial database schema.
  - **001_initial_schema.sql**: Initial SQL script to create the tables `Transactions`, `Categories`, `TransactionTypes`, and `Status`.
- **seeds/**: SQL scripts to populate the database with initial data.
  - **seed_data.sql**: Script to populate the database with basic data.
- **init_db.sql**: Script to initialize the database and create all necessary tables.
- **Dockerfile**: Docker file to create an image for the database.

#### `resources/`
- **mock_data/**: Mock data for testing and development purposes.
  - **transactions.json**: Sample data for transactions.
  - **categories.json**: Sample data for categories.
- **assets/**: A repository for various media resources such as images or icons.
  - **logo.png**: The logo of the application.
- **README.md**: Documentation for various resources and auxiliary information.

#### `docker-compose.yml`
- Docker Compose file to orchestrate all Docker containers (backend, frontend, database).

#### `README.md`
- The main documentation of the project, which should include an overall description of the project, installation instructions, usage, contribution guidelines, etc.

## Logical Design
The logical design of the application revolves around managing categories, transactions, payment statuses, and tracking whether a transaction is monthly or yearly:

1. Categories: Categories can be created, updated, deleted, and renamed. Each transaction belongs to a category. Categories are stored in a dedicated table to allow for flexibility and future changes.

2. Statuses: Similar to categories, statuses (e.g., "Disabled", "Active", "Suspended", "Cancelled") can be modified and extended. They are also stored in a dedicated table, allowing for dynamic management.

3. Transaction Frequency: Each transaction can be classified as either "Monthly" or "Yearly", depending on how frequently the expense or income occurs.

4. Transactions: Each transaction is linked to a category, a status, and a frequency. Transactions can be income or expense entries and can be edited or deleted as needed.

## Business Process
1. User Interaction: Users interact with the application through a ReactJS frontend, where they can view, add, edit, or delete transactions.

2. Category Management: Users can manage categories, assigning them to different transactions and updating them as necessary.

3. Status Management: The application allows for dynamic management of payment statuses, ensuring that users can accurately reflect the current state of their transactions.

4. Transaction Frequency: Users can specify whether a transaction is recurring monthly or yearly, which helps in planning and budget management.

## Technical Design
The backend API is responsible for handling all CRUD operations related to categories, statuses, transactions, and frequency types. NestJS will handle the routing, request validation, and interaction with the SQLite database.

### Backend (NestJS)
- **Controller Layer**: Handles incoming HTTP requests and sends responses.
- **Service Layer**: Contains business logic and interacts with the repository layer.
- **Repository Layer**: Responsible for direct interaction with the SQLite database using TypeORM.

### Frontend (ReactJS)
- **Components**: React components represent different parts of the UI (e.g., TransactionList, CategoryManager).
- **State Management**: React's state and context APIs manage the application's state.
- **API Calls**: Axios is used for making HTTP requests to the backend API.


### Database Schema
The database schema includes tables for managing transactions, categories, statuses, and frequency types. Relationships between these entities are handled using foreign keys, and SQLite views are used to generate human-readable outputs.

- **Categories Table**: Stores all categories with unique IDs.
- **Statuses Table**: Stores all statuses with unique IDs.
- **Frequency Table**: Stores frequency types (Monthly, Yearly).
- **Transactions Table**: Stores transaction details, with foreign keys linking to categories, statuses, and frequency types.

### Database Views
- **Transaction View**: A view that joins the transactions table with the categories, statuses, and frequency tables, replacing IDs with their corresponding text values. This view is used to generate user-friendly reports.

## API Endpoints
### Category Management
- `GET /categories`: Retrieve all categories.
- `POST /categories`: Create a new category.
- `PUT /categories/:id`: Update an existing category.
- `DELETE /categories/:id`: Delete a category.
### Status Management
- `GET /statuses`: Retrieve all statuses.
- `POST /statuses`: Create a new status.
- `PUT /statuses/:id`: Update an existing status.
- `DELETE /statuses/:id`: Delete a status.
### Transaction Management
`GET /transactions`: Retrieve all transactions.
`POST /transactions`: Create a new transaction.
`PUT /transactions/:id`: Update an existing transaction.
`DELETE /transactions/:id`: Delete a transaction.
### Frequency Management
`GET /frequencies`: Retrieve all frequency types.
`POST /frequencies`: Create a new frequency type.
`PUT /frequencies/:id`: Update an existing frequency type.
`DELETE /frequencies/:id`: Delete a frequency type.

## Setting Up the Project
1. Clone the Repository: git clone <repository-url>
2. Install Dependencies: Run npm install in both the backend and frontend directories.
3. Set Up SQLite: No additional setup is needed for SQLite as it is file-based. However, ensure the database file is correctly referenced in the application.
## Running the Application

1. Backend: Run npm run start in the backend directory to start the NestJS server.
2. Frontend: Run npm start in the frontend directory to start the React development server.

### Dockerization
1. Build the Docker Image: docker build -t finance-tracker .
2. Run the Docker Container: docker run -p 3000:3000 finance-tracker

## Contributing
Please read the CONTRIBUTING.md file for details on our code of conduct and the process for submitting pull requests.

## License
This project is licensed under the MIT License - see the LICENSE file for details.
