from robot.api.deco import keyword
from NetworkLogging import NetworkLogging

@keyword
def start_network_logging():
    """Starts the Selenium Wire driver with network logging."""
    network_logger = NetworkLogging()
    network_logger.start_driver()
    return network_logger

@keyword
def stop_network_logging(network_logger):
    """Stops the network logging and closes the browser."""
    network_logger.stop_driver()

@keyword
def get_network_requests(network_logger):
    """Retrieves captured network requests."""
    return network_logger.get_requests()

@keyword
def get_network_response_for_request(network_logger, request_url):
    """Retrieves the response for a specific request URL."""
    return network_logger.get_response_for_request(request_url)

@keyword
def save_network_traffic_as_har(network_logger, file_name):
    """Saves the captured network traffic as a HAR file."""
    network_logger.save_har(file_name)
