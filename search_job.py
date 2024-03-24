import googlemaps
import folium

def search_company_location(api_key, company_name):
    # Initialize Google Maps client
    gmaps = googlemaps.Client(key=api_key)

    # Perform a Places API search to find the location of the company
    places_result = gmaps.places(query=company_name)

    if places_result['status'] == 'OK':
        # Extracting the first result (assuming it's the most relevant)
        location = places_result['results'][0]['geometry']['location']
        latitude = location['lat']
        longitude = location['lng']
        return latitude, longitude
    else:
        print("Error occurred while fetching company location.")
        return None, None

def show_map(company_name, latitude, longitude):
    # Create a folium map centered around the company's location
    company_map = folium.Map(location=[latitude, longitude], zoom_start=15)

    # Add a marker for the company
    folium.Marker(location=[latitude, longitude], popup=company_name).add_to(company_map)

    # Save the map to an HTML file
    company_map.save("company_location_map.html")

if __name__ == "__main__":
    # Replace 'YOUR_API_KEY' with your actual Google Maps API key
    api_key = 'YOUR_API_KEY'

    # Replace 'Company Name' with the name of the company you want to search for
    company_name = 'IFPB - Campus João Pessoa'

    # Search for the company's location
    latitude, longitude = search_company_location(api_key, company_name)

    if latitude is not None and longitude is not None:
        # Display the map
        show_map(company_name, latitude, longitude)
