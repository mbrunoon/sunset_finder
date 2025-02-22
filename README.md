# README


## To install and run:

- Get a API Key in [Geocoding API](https://geocode.maps.co) and add in a `GEOCODE_KEY` environment variable.
- Run the application:    
  - Create database: `rails db:create`
  - Run Migrations: `rails db:migrate`
  - Run rails server: `rails s`

## Database model

- **Sunsets**:
  - location: string
  - occurs_at: date
  - data: json
  
## APIs consulted

- [Sunset API](https://sunrisesunset.io/api/): return sunset data;
- [Geocoding API](https://geocode.maps.co): get lat,long from location;

## Remaining activities
- Write more automated tests involving different scenarios;
- Implement Redis cache;
- Create a docker environment (and docker compose file);
- Deploy in a Heroku Server;
- Front-end development;

# Demo



https://github.com/user-attachments/assets/774558ec-5c2d-4af1-844f-6ab122c86dfd

