# E-commerce Automation Testing Project
This project demonstrates automated testing for an e-commerce website using Robot Framework. The test suite covers essential e-commerce functionalities including user registration, login, product search, shopping cart management, and checkout process.

## Project Structure
automation/
├── testcase/ # Test suite files
│ ├── 01_signup.robot 
│ ├── 02_account_information.robot
│ ├── 03_login.robot 
│ ├── 04_product_search.robot
│ ├── 05_add_cart.robot
│ ├── 06_checkout.robot
│ └── 09_delete_account.robot
├── resources/ # Shared resources
│ ├── common_keywords.robot # Reusable keywords
│ └── common_variables.robot # Global variables
└── results/ # Test execution results

## Installation
```bash
# Clone the repository
git clone [your-repo-url]
# Install dependencies
pip install robotframework-seleniumlibrary
pip install robotframework-requests  
```

## Running Tests
```bash
# Run full flow 
robot --exclude browser .\testcase\
```