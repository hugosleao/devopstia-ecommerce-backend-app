FROM mcr.microsoft.com/dotnet/sdk:7.0-alpine AS builder
WORKDIR /app
COPY DevopstiaApp/ .
ENV ASPNETCORE_ENVIRONMENT Development
ENV URLS http://0.0.0.0:80
RUN dotnet publish -c Release -o build DevopstiaApp.csproj

FROM mcr.microsoft.com/dotnet/aspnet:7.0-alpine AS runner
WORKDIR /app
COPY --from=builder /app/build /app/
EXPOSE 80
ENTRYPOINT ["dotnet", "/app/DevopstiaApp.dll"] 