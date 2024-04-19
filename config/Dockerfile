

FROM mcr.microsoft.com/dotnet/sdk:8.0-alpine3.18 AS build-env
WORKDIR /App

COPY ./src/Ecommerce.Identity.API/. ./Ecommerce.Identity.API
COPY ./src/dlls/. ./dlls

RUN dotnet restore "./Ecommerce.Identity.API/Ecommerce.Identity.API.csproj"


RUN dotnet publish "./Ecommerce.Identity.API/Ecommerce.Identity.API.csproj" -c Release -o out

FROM mcr.microsoft.com/dotnet/aspnet:8.0-alpine3.18

WORKDIR /App
COPY --from=build-env /App/out .

EXPOSE 8080

ENTRYPOINT ["dotnet", "Ecommerce.Identity.API.dll"]
