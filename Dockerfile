FROM mcr.microsoft.com/dotnet/core/sdk:3.1 AS build
WORKDIR /app

# copy csproj and restore distinct layers
COPY *.sln .
COPY Remus/*.csproj ./Remus/
RUN dotnet restore

# copy everything else and build app
COPY Remus/. ./Remus/
WORKDIR /app/Remus
RUN dotnet publish -c Release -o out


FROM mcr.microsoft.com/dotnet/core/aspnet:3.1 AS runtime
WORKDIR /app
COPY --from=build /app/Remus/out ./
ENTRYPOINT ["dotnet", "Remus.dll"]
