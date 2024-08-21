# Official PostgreSQL image
FROM postgres:latest

# Set environment variables for PostgreSQL
ENV POSTGRES_DB=pricetag
ENV POSTGRES_USER=administrator
ENV POSTGRES_PASSWORD=StrongPass2024!

# Copy base structure from file into container
COPY ./src/main/resources/initdb_postgresql.sql /docker-entrypoint-initdb.d/pricetag_structure.sql

# Expose port for connect to database
EXPOSE 5432
