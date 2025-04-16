# E-commerce Automation Testing Project
This project demonstrates automated testing for an e-commerce website using Robot Framework. The test suite covers essential e-commerce functionalities including user registration, login, product search, shopping cart management, and checkout process.

## Project Structure
├── testcase/ # Test suite files
│ ├── 01_signup.robot # User registration tests
│ ├── 02_account_information.robot
│ ├── 03_login.robot # Authentication tests
│ ├── 04_product_search.robot
│ ├── 05_add_cart.robot
│ ├── 06_checkout.robot
│ └── 07_delete_account.robot
├── resources/ # Shared resources
│ ├── common_keywords.robot # Reusable keywords
│ └── common_variables.robot # Global variables
└── results/ # Test execution results

## Installation
```bash
# Clone the repository
git clone https://github.com/namebank/Robot-Framwork-automationexercise.com-.git
# Install dependencies
pip install robotframework-seleniumlibrary
pip install robotframework-requests  
```

## Running Tests
```bash
# Run full flow 
robot --exclude browser .\testcase\
```
