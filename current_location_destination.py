import googlemaps
import gmplot

def get_coordinates(api_key, name):
    gmaps = googlemaps.Client(key=api_key)
    
    # Perform a Places API search to find the location of the company
    places_result = gmaps.places(query=name)

    if places_result['status'] == 'OK':
        # Extracting the first result (assuming it's the most relevant)
        location = places_result['results'][0]['geometry']['location']
        return location
    else:
        print("Error occurred while fetching location.")
        return None

def show_map(current_location, destination):
    # Initialize the map at the center of current location
    gmap = gmplot.GoogleMapPlotter(current_location['lat'], current_location['lng'], 13)

    # Add markers for current location and destination
    gmap.marker(current_location['lat'], current_location['lng'], 'cornflowerblue', title="Your Location")
    gmap.marker(destination['lat'], destination['lng'], 'red', title="Destination")

    # Draw the map
    gmap.draw("map.html")
    print("Map saved as map.html")

if __name__ == "__main__":
    # Replace 'YOUR_API_KEY' with your actual Google Maps API key
    api_key = 'YOUR_API_KEY'

    # Replace 'Your Address' with your current location
    my_location = 'Feirinha de Artesanato de Tambaú'

    # Search for the company's location
    current_location = get_coordinates(api_key, my_location)

    dest_location = 'IFPB - Campus João Pessoa'
    # Replace 'Destination Address' with your destination location
    destination = get_coordinates(api_key, dest_location)

    # Display the map
    show_map(current_location, destination)
