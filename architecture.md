## SecureVault Flutter App Architecture

This document outlines the full architecture of the SecureVault application, built with Flutter and leveraging AES-256 encryption for 100% local storage. It includes the file and folder structure along with descriptions of each component.

---

### 📁 Root Structure

```
secure_vault/
├── android/
├── ios/
├── lib/
├── assets/
├── test/
├── .gitignore
├── pubspec.yaml
├── README.md
└── LICENSE
```

* **android/**: Native Android project files.
* **ios/**: Native iOS project files.
* **lib/**: Main Dart codebase.
* **assets/**: Static assets like icons and fonts.
* **test/**: Unit and widget tests.
* **.gitignore**: Files and folders to ignore in version control.
* **pubspec.yaml**: Project metadata and dependencies.
* **README.md**: Project overview and setup instructions.
* **LICENSE**: Licensing information.

---

### 📂 lib/

```
lib/
├── main.dart
├── core/
│   ├── constants/
│   │   └── app_constants.dart
│   ├── enums/
│   │   └── vault_item_type.dart
│   └── utils/
│       └── decrypt_encrypt.dart
├── data/
│   ├── models/
│   │   └── vault_item.dart
│   ├── repositories/
│   │   └── vault_repository.dart
│   └── storage/
│       └── vault_storage.dart
├── services/
│   └── biometric_service.dart
├── ui/
│   ├── screens/
│   │   ├── login_screen.dart
│   │   ├── vault_list_screen.dart
│   │   ├── item_detail_screen.dart
│   │   └── settings_screen.dart
│   └── widgets/
│       ├── vault_item_card.dart
│       ├── encrypted_text_field.dart
│       └── biometric_button.dart
└── app.dart
```

#### 1. `main.dart`

* App entry point. Initializes necessary services (storage, encryption) and runs the `App` widget.

#### 2. `app.dart`

* Sets up `MaterialApp`, routes, theme, and global providers (e.g., `Provider` or `GetX` bindings).

---

#### 3. `core/constants/app_constants.dart`

* Contains hardcoded constants (e.g., storage file names, encryption key aliases).

#### 4. `core/enums/vault_item_type.dart`

* Enum defining types of vault items (password, note, card, PIN, etc.).

#### 5. `core/utils/decrypt_encrypt.dart`

* Implements AES-256 encryption/decryption. Provides methods to encrypt data before storage and decrypt on retrieval.

---

#### 6. `data/models/vault_item.dart`

* `VaultItem` model class. Defines fields such as `id`, `type`, `title`, `encryptedData`, `timestamp`.
* Includes serialization and deserialization to/from JSON for import/export.

#### 7. `data/repositories/vault_repository.dart`

* Abstracts data operations. Methods to add, update, delete, fetch items. Uses `VaultStorage` internally.

#### 8. `data/storage/vault_storage.dart`

* Low-level file I/O using `path_provider` and `dart:io`.
* Manages a single encrypted JSON file on-device. Handles import/export of JSON/CSV backups.

---

#### 9. `services/biometric_service.dart`

* Wraps `local_auth` plugin.
* Checks device support, triggers Face ID or fingerprint authentication.
* Returns success/failure to UI for unlocking.

---

#### 10. `ui/screens/`

* **login\_screen.dart**: Prompts for biometric login or master PIN. Upon success, navigates to `vault_list`.
* **vault\_list\_screen.dart**: Displays all `VaultItem`s in a list. Provides search and filter capabilities.
* **item\_detail\_screen.dart**: Shows decrypted content of a selected item. Allows edit, copy to clipboard, or deletion.
* **settings\_screen.dart**: Options for export/import, change master PIN, app theme, and other preferences.

---

#### 11. `ui/widgets/`

* **vault\_item\_card.dart**: UI representation of a vault entry in the list (title, icon, timestamp).
* **encrypted\_text\_field.dart**: Custom `TextField` that obscures decrypted text until reveal action.
* **biometric\_button.dart**: Reusable button widget to trigger biometric login.

---

### 📁 assets/

```
assets/
├── icons/
│   └── vault_icon.png
├── fonts/
│   └── Roboto-Regular.ttf
└── translations/
    └── en.json
```

* **icons/**: App logo and feature icons.
* **fonts/**: Custom font files.
* **translations/**: JSON for localization (future-proofing).

---

### 📁 test/

```
test/
├── unit/
│   ├── decrypt_encrypt_test.dart
│   └── vault_item_test.dart
└── widget/
    └── login_screen_test.dart
```

* **unit/**: Tests for core utilities and models.
* **widget/**: UI tests for screens and widgets.

---

### Dependencies

```yaml
dependencies:
  flutter:
    sdk: flutter
  local_auth: ^2.1.0
  path_provider: ^2.0.0
  provider: ^6.0.0
  intl: ^0.17.0

dev_dependencies:
  flutter_test:
    sdk: flutter
  mockito: ^5.0.0
  build_runner: ^2.1.0
```
