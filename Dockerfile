# Etapa 1: Build (Usamos el SDK para compilar)
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src

# Copiamos el archivo de proyecto y restauramos las dependencias
COPY ["DemoDevOps.csproj", "./"]
RUN dotnet restore

# Copiamos el resto de los archivos y compilamos
COPY . .
RUN dotnet publish "DemoDevOps.csproj" -c Release -o /app/publish

# Etapa 2: Runtime (Imagen liviana para ejecutar)
FROM mcr.microsoft.com/dotnet/runtime:8.0 AS final
WORKDIR /app
COPY --from=build /app/publish .

# Comando para arrancar la app
ENTRYPOINT ["dotnet", "DemoDevOps.dll"]
