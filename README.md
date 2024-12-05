# Python Robot and Selenium Framework

This project is a Python-based robot and Selenium framework designed to run automated tests on Browsers.

## Project Structure

```
python_robot_tests/
├── resources/
│   ├── common/
│   │   ├── generic_functions.robot
│   │   └── setup_teardown.robot
│   ├── page_objects/
│   │   ├── role_res.robot
│   └── keywords/
│  
├── tests/
│   ├── regression/
│   │   └── sanity.robot
├── config/
│   └── common_config.yaml
├── .gitignore
├── README.md
└── requirements.txt
```

## Prerequisites

- Python 3.x
- Chrome browser
- ChromeDriver

## Setup

1. Clone the repository:

2. Create a virtual environment:
   ```
   python -m venv venv
   ```

3. Activate the virtual environment:
   - On Windows:
     ```
     venv\Scripts\activate
     ```
   - On macOS and Linux:
     ```
     source venv/bin/activate
     ```

4. Install the required packages:
   ```
   pip install -r requirements.txt
   ```

5. Download ChromeDriver that matches your Chrome version and add it to your system PATH.

## Configuration

1. Update the `Variable/config.py` file with your test environment settings.
2. Modify the `Resource/common.robot` file to include any shared keywords or setup/teardown procedures.

## Running Tests

To run all tests:
```
robot -d results Testsuite
```

To run a specific test suite:
```
robot -d results Testsuite/your_test_suite.robot
```

To run tests with specific tags:
```
robot -d results -i smoke Testsuite
```

## Generating Reports

Robot Framework automatically generates reports and logs. After running tests, you can find them in the `results` directory:

- `report.html`: Overall test results
- `log.html`: Detailed test execution logs
- `output.xml`: Raw test data in XML format

## Maintenance

Regular updates to the framework components:

1. Update ChromeDriver to match your Chrome browser version.
2. Keep Python packages up-to-date:
   ```
   pip install --upgrade -r requirements.txt
   ```
3. Review and update test cases in the `Testsuite/` directory as needed.
4. Maintain shared resources and variables in their respective directories.

## Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request
