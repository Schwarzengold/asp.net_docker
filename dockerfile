FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /app

COPY ["Web Menu.sln", "."]
COPY ["Web Menu/Web Menu.csproj", "Web Menu/"]
COPY "WebMenu.BusinessLogic/WebMenu.BusinessLogic.csproj" "WebMenu.BusinessLogic/"
COPY "WebMenu.DataAccess/WebMenu.DataAccess.csproj" "WebMenu.DataAccess/"

RUN dotnet restore "Web Menu.sln"

COPY . .

RUN dotnet publish "Web Menu/Web Menu.csproj" -c Release -o /app/publish

FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS runtime
WORKDIR /app
COPY --from=build /app/publish .
ENTRYPOINT ["dotnet", "Web Menu.dll"]
