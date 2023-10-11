#stage1: Build the application
FROM mcr.microsoft.com/dotnet/sdk:7.0 as buildnet
MAINTAINER BALA<balaknuthi999@gmail.com>

#Setting the working directory
WORKDIR /app


# Copy the .csproj and restore as distinct layers
COPY BalaDotnet_Github.csproj BalaDotnet_Github.csproj

RUN dotnet restore

# Copy the remaining source code
COPY . .

#Build the application with release configuration
RUN dotnet publish -c Release -o /app/publish


# Stage 2: Create a runtime image
FROM mcr.microsoft.com/dotnet/aspnet:7.0 AS runtime

WORKDIR /app
COPY --from=buildnet /app/publish .

#Expose a port if your application listens on a specific port
EXPOSE 80

# Start the application
ENTRYPOINT ["dotnet", "BalaDotnet_Github.dll"]
