# BakeryApp
# Информационная система хлебозавода №1

## Описание проекта

Информационная система для управления производственными и коммерческими операциями хлебозавода. Разработана на WPF (.NET 8) с использованием паттерна MVVM и базы данных SQL Server.

---

## Технологический стек

| Компонент | Технология |
|---|---|
| Платформа | .NET 8 (Windows) |
| UI-фреймворк | WPF (Windows Presentation Foundation) |
| Паттерн | MVVM (Model-View-ViewModel) |
| База данных | SQL Server (SSMS) |
| ORM | Entity Framework Core 8 |
| Отчёты (Excel) | ClosedXML (.xlsx) |
| Отчёты (PDF) | iText7 (.pdf, с поддержкой кириллицы) |
| Безопасность | SHA-256 хэширование паролей |

---

## Структура проекта

```
BakeryApp/
├── BakeryApp.sln                    # Файл решения Visual Studio
├── BakeryDB_Script.sql              # SQL скрипт создания БД
├── ER-diagram.png                   # ER-диаграмма (PNG)
├── ER-diagram.pdf                   # ER-диаграмма (PDF)
├── README.md                        # Документация
├── Полная_документация.md           # Полная документация проекта
│
├── Assets/
│   ├── Products_Template.xlsx       # Шаблон импорта продукции
│   ├── Clients_Template.xlsx        # Шаблон импорта клиентов
│   └── Suppliers_Template.xlsx      # Шаблон импорта поставщиков
│
└── BakeryApp/
    ├── BakeryApp.csproj             # Файл проекта
    ├── App.xaml / App.xaml.cs       # Точка входа, ресурсы
    ├── appsettings.json             # Конфигурация подключения
    │
    ├── Assets/
    │   ├── Icons/app.ico            # Иконка приложения
    │   └── Images/                  # Изображения (логотип, продукты)
    │
    ├── Models/                      # Модели данных (EF Core)
    │   ├── BakeryDbContext.cs       # Контекст БД
    │   ├── Role.cs                  # Роль пользователя
    │   ├── User.cs                  # Пользователь системы
    │   ├── Product.cs               # Продукция
    │   ├── Supplier.cs              # Поставщик
    │   ├── Client.cs                # Клиент
    │   ├── Order.cs                 # Заказ
    │   └── OrderDetail.cs           # Позиция заказа
    │
    ├── ViewModels/                  # Логика представлений (MVVM)
    │   ├── BaseViewModel.cs         # Базовый класс (INotifyPropertyChanged)
    │   ├── RelayCommand.cs          # Реализация ICommand
    │   ├── LoginViewModel.cs        # Авторизация
    │   ├── ProductsViewModel.cs     # Управление продукцией
    │   ├── OrdersViewModel.cs       # Управление заказами
    │   ├── ClientsViewModel.cs      # Управление клиентами
    │   ├── SuppliersViewModel.cs    # Управление поставщиками
    │   └── UsersViewModel.cs        # Управление пользователями
    │
    ├── Views/                       # Представления (XAML)
    │   ├── LoginWindow.xaml/.cs     # Окно авторизации
    │   ├── MainWindow.xaml/.cs      # Главное окно с навигацией
    │   ├── HomePage.xaml/.cs        # Дашборд
    │   ├── ProductsPage.xaml/.cs    # Список продукции
    │   ├── ProductEditWindow.xaml/.cs # Форма продукта
    │   ├── OrdersPage.xaml/.cs      # Список заказов
    │   ├── OrderEditWindow.xaml/.cs # Форма заказа
    │   ├── ClientsPage.xaml/.cs     # Список клиентов
    │   ├── ClientEditWindow.xaml/.cs # Форма клиента
    │   ├── SuppliersPage.xaml/.cs   # Список поставщиков
    │   ├── SupplierEditWindow.xaml/.cs # Форма поставщика
    │   ├── UsersPage.xaml/.cs       # Список пользователей
    │   ├── UserEditWindow.xaml/.cs  # Форма пользователя
    │   ├── ReportsPage.xaml/.cs     # Страница отчётов
    │   ├── UpdatePricesWindow.xaml/.cs # Обновление цен
    │   └── BulkUpdateSuppliersWindow.xaml/.cs # Массовое обновление
    │
    ├── Helpers/                     # Вспомогательные классы
    │   ├── SessionManager.cs        # Управление сессией и ролями
    │   ├── PasswordHelper.cs        # Хэширование паролей
    │   ├── ConfigurationHelper.cs   # Чтение конфигурации
    │   ├── BoolToVisibilityConverter.cs
    │   └── StringToVisibilityConverter.cs
    │
    └── Reports/
        └── ReportGenerator.cs       # Генератор отчётов (Excel + PDF)
```

---

## Установка и запуск

### Требования

- **Windows 10/11** (WPF работает только на Windows)
- **Visual Studio 2022** (версия 17.0 или выше)
- **.NET 8 SDK** (включён в Visual Studio 2022)
- **SQL Server** (Express, Developer или полная версия)
- **SQL Server Management Studio (SSMS)** 18+

### Шаг 1: Создание базы данных

1. Откройте **SQL Server Management Studio**
2. Подключитесь к серверу (по умолчанию `localhost\SQLEXPRESS`)
3. Откройте файл `BakeryDB_Script.sql`
4. Нажмите **F5** или кнопку **Execute** для выполнения скрипта
5. Убедитесь, что в списке баз данных появилась `Bakery`

### Шаг 2: Настройка строки подключения

Откройте файл `BakeryApp/appsettings.json` и при необходимости измените строку подключения:

```json
{
  "ConnectionStrings": {
    "DefaultConnection": "Server=localhost\\SQLEXPRESS;Database=Bakery;Trusted_Connection=True;TrustServerCertificate=True;"
  }
}
```

### Шаг 3: Открытие проекта

1. Откройте файл `BakeryApp.sln` в **Visual Studio 2022**
2. Дождитесь восстановления NuGet-пакетов (автоматически)
3. Нажмите **F5** или **Ctrl+F5** для запуска

---

## Учётные данные по умолчанию

| Пользователь | Пароль | Роль |
|---|---|---|
| `admin` | `admin123` | Администратор |
| `manager1` | `manager123` | Менеджер по продажам |
| `manager2` | `manager123` | Менеджер по продажам |
| `stock_user` | `stock123` | Складской работник |

---

## Функциональность по ролям

### Администратор
- Полный доступ ко всем функциям системы
- Управление пользователями и ролями
- Удаление любых записей
- Обновление цен на продукцию
- Массовое обновление поставщиков
- Формирование и экспорт отчётов (Excel + PDF)

### Менеджер по продажам
- Просмотр и редактирование продукции (без удаления)
- Создание, редактирование заказов (без удаления)
- Управление клиентами (добавление, редактирование)
- Просмотр и редактирование поставщиков (без удаления и массового обновления)
- Формирование и экспорт отчётов (Excel + PDF)
- Нет доступа к управлению пользователями

### Складской работник
- Просмотр продукции и остатков на складе (только чтение)
- Нет доступа к заказам, клиентам, поставщикам
- Просмотр и экспорт отчёта о складе (Excel + PDF)
- Нет доступа к отчёту о продажах
- Нет доступа к управлению пользователями

---

## Описание модулей

### Дашборд (Главная страница)
Отображает ключевые показатели: количество наименований продукции, количество активных заказов, количество клиентов, общую стоимость склада, последние 5 заказов и продукцию с низким остатком (< 50 единиц).

### Управление продукцией
Полный CRUD (создание, чтение, обновление, удаление). Фильтрация по категории и поиск по наименованию. Вычисление общей стоимости склада. Программное обновление цен (по категории, в % или фиксированное значение).

### Управление заказами
Полный CRUD для заказов. Добавление/удаление позиций заказа. Фильтрация по статусу и поиск по клиенту. Автоматический расчёт суммы заказа. Статусы: Новый → В обработке → Выполнен / Отменён.

### Управление клиентами
Полный CRUD. Поиск по наименованию. Защита от удаления клиентов с активными заказами.

### Управление поставщиками
Полный CRUD. Поиск по наименованию. Массовое обновление контактной информации.

### Отчёты

**Отчёт о продажах:**
- Выбор периода (дата начала / дата окончания)
- Детализация по позициям заказов
- Итоговая сумма продаж
- Экспорт в Excel (.xlsx) и PDF (.pdf)

**Отчёт о запасах на складе:**
- Текущие остатки по всем продуктам
- Группировка по категориям
- Общая стоимость склада
- Экспорт в Excel (.xlsx) и PDF (.pdf)

---

## Схема базы данных

```
Roles (RoleID, RoleName)
    ↑
Users (UserID, Username, PasswordHash, RoleID)

Clients (ClientID, Name, ContactInfo)
    ↑
Orders (OrderID, ClientID, OrderDate, Status)
    ↑
OrderDetails (OrderDetailID, OrderID, ProductID, Quantity)
    ↑
Products (ProductID, Name, Category, Price, StockQuantity)

Suppliers (SupplierID, Name, ContactInfo)
```

---

## Цветовая схема

| Цвет | HEX | Назначение |
|---|---|---|
| Коричневый | `#8B4513` | Основной цвет (кнопки, заголовки) |
| Тёмно-коричневый | `#D2691E` | Вторичный цвет (hover-эффекты) |
| Золотистый | `#F4A460` | Акцентный цвет |
| Кремовый | `#FFF8F0` | Фон приложения |
| Зелёный | `#388E3C` | Успешные операции |
| Оранжевый | `#F57C00` | Предупреждения |
| Красный | `#C62828` | Ошибки, удаление |

---

## Зависимости (NuGet пакеты)

| Пакет | Версия | Назначение |
|---|---|---|
| `Microsoft.EntityFrameworkCore` | 8.0.0 | ORM для работы с БД |
| `Microsoft.EntityFrameworkCore.SqlServer` | 8.0.0 | Провайдер SQL Server |
| `Microsoft.EntityFrameworkCore.Tools` | 8.0.0 | Инструменты EF Core |
| `Microsoft.Extensions.Configuration` | 8.0.0 | Работа с конфигурацией |
| `Microsoft.Extensions.Configuration.Json` | 8.0.0 | Чтение JSON-конфигурации |
| `ClosedXML` | 0.102.2 | Создание Excel-файлов |
| `itext7` | 8.0.2 | Создание PDF-файлов |
| `itext7.bouncy-castle-adapter` | 8.0.2 | Криптографический адаптер для iText7 |

---

*Разработано для учебного задания. Вариант 12.*
