# SecureVault MVP Task Plan

A **granular, one-concern-per-task** plan to build the SecureVault MVP. Each task has a clear **start**, a **finish condition**, and is small enough to hand off to an engineering LLM for isolated implementation and testing.

---

## 1. Project Initialization

1. **Create Flutter project**  
   - **Start:** Run `flutter create secure_vault`  
   - **End:** `flutter run` shows a blank Flutter app  

2. **Configure version control**  
   - **Start:** Add a `.gitignore` file to the root  
   - **End:** `git status` shows only project files staged, no build artifacts  

3. **Add dependencies**  
   - **Start:** Edit `pubspec.yaml` to include `local_auth`, `path_provider`, `provider`, `intl`  
   - **End:** `flutter pub get` completes without errors  

---

## 2. Core Utilities

4. **Define constants file**  
   - **Start:** Create `lib/core/constants/app_constants.dart`  
   - **End:** Contains at least `const String storageFile = 'vault.json';`  

5. **Stub encryption util**  
   - **Start:** Create `lib/core/utils/decrypt_encrypt.dart` with empty `encrypt()`/`decrypt()` methods  
   - **End:** Methods compile; add a unit test that calls them without error  

6. **Implement AES-256 logic**  
   - **Start:** Fill in encryption/decryption logic (e.g. using `encrypt` package)  
   - **End:** Unit test asserts `decrypt(encrypt('hello')) == 'hello'`  

---

## 3. Data Layer

7. **Define `VaultItem` model**  
   - **Start:** Create `lib/data/models/vault_item.dart` with fields `id`, `type`, `title`, `encryptedData`, `timestamp`  
   - **End:** JSON serialization methods exist and pass a round-trip test  

8. **Stub `VaultStorage` I/O**  
   - **Start:** Create `lib/data/storage/vault_storage.dart` with `readAll()`/`writeAll()` stubs  
   - **End:** Methods compile and return an empty list / no-op write  

9. **Implement file read/write**  
   - **Start:** Use `path_provider` + `dart:io` in `VaultStorage`  
   - **End:** Test writes a file under app documents dir and reads the same content back  

10. **Build `VaultRepository` API**  
    - **Start:** Create `lib/data/repositories/vault_repository.dart` with `add()`, `delete()`, `update()`, `getAll()` methods  
    - **End:** Unit test with in-memory stub of `VaultStorage` verifies each CRUD method  

---

## 4. Biometric Service

11. **Stub `BiometricService`**  
    - **Start:** Create `lib/services/biometric_service.dart` with unimplemented `Future<bool> authenticate()`  
    - **End:** Compiles; `authenticate()` can be called  

12. **Integrate `local_auth`**  
    - **Start:** Implement `authenticate()` to call `LocalAuthentication.authenticate()`  
    - **End:** On a device/emulator, calling `authenticate()` prompts face/fingerprint and returns `true`/`false`  

---

## 5. UI Shell & Navigation

13. **App entry & routing**  
    - **Start:** In `lib/main.dart`, initialize services and run `App()`  
    - **End:** `lib/app.dart` sets up `MaterialApp` with an empty `/login` route  

14. **LoginScreen scaffold**  
    - **Start:** Create `lib/ui/screens/login_screen.dart` with a biometric button placeholder  
    - **End:** Navigating to `/login` shows the screen with a tappable button  

15. **Navigation flow test**  
    - **Start:** Wire button on `LoginScreen` to stubbed `authenticate()`  
    - **End:** On success, navigator pushes `/vault_list`  

---

## 6. UI: Vault List & Detail

16. **VaultListScreen scaffold**  
    - **Start:** Create `lib/ui/screens/vault_list_screen.dart` with an empty `ListView`  
    - **End:** `/vault_list` shows an empty list UI  

17. **ItemDetailScreen scaffold**  
    - **Start:** Create `lib/ui/screens/item_detail_screen.dart` reading an `id` param  
    - **End:** `/item/1` shows a blank detail page  

18. **SettingsScreen scaffold**  
    - **Start:** Create `lib/ui/screens/settings_screen.dart`  
    - **End:** `/settings` shows static “Settings” text  

---

## 7. UI Components

19. **VaultItemCard widget**  
    - **Start:** Create `lib/ui/widgets/vault_item_card.dart` with a `title` property  
    - **End:** Widget test ensures it renders given text  

20. **EncryptedTextField widget**  
    - **Start:** Create `lib/ui/widgets/encrypted_text_field.dart` with obscured input and reveal toggle  
    - **End:** Toggling reveal shows plain text in a widget test  

21. **BiometricButton widget**  
    - **Start:** Create `lib/ui/widgets/biometric_button.dart` that calls a passed `onTap`  
    - **End:** Tapping in a widget test invokes the callback  

---

## 8. Import/Export Feature

22. **Export JSON**  
    - **Start:** Add `exportToJson()` in `VaultStorage` returning encrypted JSON string  
    - **End:** Unit test asserts the returned string is valid JSON and decryptable  

23. **Import JSON**  
    - **Start:** Add `importFromJson(String)` that parses and writes vault items  
    - **End:** Round-trip test: export then import yields identical `VaultItem` list  

---

## 9. Asset & Localization Setup

24. **Add icons & fonts**  
    - **Start:** Place `vault_icon.png` in `assets/icons`, Roboto font in `assets/fonts`  
    - **End:** Referencing them in `pubspec.yaml` allows `Image.asset` and `TextStyle(fontFamily)`  

25. **Initial translation file**  
    - **Start:** Create `assets/translations/en.json` with keys for “login”, “settings”, etc.  
    - **End:** Load via `intl` and display on LoginScreen  

---

## 10. Testing & Validation

26. **Unit test suite**  
    - **Start:** Write tests for core/utils, data layer, and service classes  
    - **End:** `flutter test` passes all tests  

27. **Widget smoke tests**  
    - **Start:** Write basic `pumpWidget` tests for each screen and widget  
    - **End:** All widget tests pass without errors  

---

## 11. Demo & Handoff

28. **Build debug APK/IPA**  
    - **Start:** Run `flutter build apk` (or `flutter build ios`)  
    - **End:** Generated package installs and launches to LoginScreen  

29. **MVP demo script**  
    - **Start:** Document: login → empty vault → import sample JSON → view items  
    - **End:** Engineer follows script to verify core flows  

---
