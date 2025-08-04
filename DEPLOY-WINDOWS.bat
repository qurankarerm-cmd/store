@echo off
title Arabic Clay Store - Windows Deployment

echo.
echo 🌟 Deploying Arabic Clay Store on Windows 🌟
echo ================================================
echo.

:: Check if Docker is installed
docker --version >nul 2>&1
if errorlevel 1 (
    echo ❌ ERROR: Docker is not installed!
    echo.
    echo Please install Docker Desktop for Windows:
    echo 1. Visit: https://docs.docker.com/desktop/install/windows-installer/
    echo 2. Download and install Docker Desktop
    echo 3. Restart your computer
    echo 4. Start Docker Desktop
    echo 5. Run this script again
    echo.
    pause
    exit /b 1
)

:: Check if Docker is running
docker info >nul 2>&1
if errorlevel 1 (
    echo ❌ ERROR: Docker is not running!
    echo.
    echo Please:
    echo 1. Start Docker Desktop from Start Menu
    echo 2. Wait for Docker to fully start (whale icon in system tray)
    echo 3. Run this script again
    echo.
    pause
    exit /b 1
)

echo ✅ Docker is installed and running!
echo.

:: Choose deployment type
echo Choose deployment type:
echo 1) 🚀 Production (Recommended for live use)
echo 2) 🔧 Development (With hot reload for coding)
echo.
set /p choice="Enter your choice (1 or 2): "

if "%choice%"=="1" goto production
if "%choice%"=="2" goto development

echo ❌ Invalid choice! Please enter 1 or 2.
pause
exit /b 1

:production
echo.
echo 🚀 Deploying PRODUCTION environment...
echo ⏳ This may take a few minutes for the first time...
echo.

docker-compose up --build -d

if errorlevel 1 (
    echo ❌ Deployment failed! Check the error messages above.
    pause
    exit /b 1
)

echo.
echo ✅ Production deployment successful!
goto success

:development
echo.
echo 🔧 Deploying DEVELOPMENT environment...
echo ⏳ This may take a few minutes for the first time...
echo.

docker-compose -f docker-compose.dev.yml up --build -d

if errorlevel 1 (
    echo ❌ Deployment failed! Check the error messages above.
    pause
    exit /b 1
)

echo.
echo ✅ Development deployment successful!
goto success

:success
echo.
echo 🎉 DEPLOYMENT COMPLETE! 🎉
echo ================================
echo.
echo Your Arabic Clay Store is now running!
echo.
echo 🌐 Access your applications:
echo   • Public Website:    http://localhost:3000
echo   • Admin Dashboard:   http://localhost:3001
echo   • API Server:        http://localhost:5000
echo.
echo 🔑 Default admin login:
echo   • Username: admin
echo   • Password: admin123
echo   ⚠️  Change password after first login!
echo.
echo 📊 Useful commands:
echo   • Check status:      docker-compose ps
echo   • View logs:         docker-compose logs -f
echo   • Stop services:     docker-compose down
echo   • Restart services:  docker-compose restart
echo.
echo 💡 Tip: Keep Docker Desktop running for the store to work!
echo.

:: Ask if user wants to open the website
set /p open="Open the website in browser? (y/n): "
if /i "%open%"=="y" (
    start http://localhost:3000
    start http://localhost:3001
)

echo.
echo Press any key to exit...
pause >nul