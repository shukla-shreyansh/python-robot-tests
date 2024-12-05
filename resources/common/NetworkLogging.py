from seleniumwire import webdriver
from selenium.webdriver.chrome.service import Service
from selenium.webdriver.common.by import By
from webdriver_manager.chrome import ChromeDriverManager
import sys
import time
import json

class NetworkLogging:
    def __init__(self):
        # Default Selenium Wire Options
        self.selenium_wire_options = {
            'enable_har': True,  # Enable HAR capture for requests/responses
            'verify_ssl': False,  # Disable SSL verification (useful for HTTPS requests)
        }
        self.driver = None

    def start_driver(self):
        # Setup Chrome options
        options = sys.modules['selenium.webdriver'].ChromeOptions()
        options.add_argument('--ignore-certificate-errors')  # Ignore SSL certificate errors

        # Initialize WebDriver with Selenium Wire and Chrome Options
        self.driver = webdriver.Chrome(
            service=Service(ChromeDriverManager().install()),
            options=options,
            seleniumwire_options=self.selenium_wire_options
        )
        time.sleep(3)  # Allow time for driver setup

    def get_requests(self):
        """Retrieve captured HTTP requests"""
        print(f"Captured requests: {self.driver.requests}")  # Debugging line
        return self.driver.requests

    def get_response_for_request(self, request_url):
        # Find response for a particular request
        for request in self.driver.requests:
            if request.url == request_url and request.response:
                return request.response
        return None

    def stop_driver(self):
        # Close the browser
        if self.driver:
            self.driver.quit()

    def save_har(self, file_name):
        """Saves the captured network traffic as a HAR file."""
        har_data = self.driver.requests.har
        print(f"Captured HAR data: {har_data}")  # Debugging line
        if har_data:
            with open(file_name, 'w') as f:
                json.dump(har_data, f)  # Save the HAR data to a file
        else:
            print("No HAR data found!")
