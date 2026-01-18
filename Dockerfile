FROM mcr.microsoft.com/dotnet/sdk:7.0-alpine AS builder
WORKDIR /app
COPY YoutubeLiveApp/ .
ENV ASPNETCORE_ENVIRONMENT Development
ENV URLS http://0.0.0.0:80
RUN dotnet publish -c Release -o build YoutubeLiveApp.csproj

FROM mcr.microsoft.com/dotnet/aspnet:7.0-alpine AS runner
WORKDIR /app
COPY --from=builder /app/build /app/
EXPOSE 80
ENTRYPOINT ["dotnet", "/app/YoutubeLiveApp.dll"] 