# Vaja 2: Mobilna Flutter Aplikacija za Vnos Podatkov o Zaposlenih

## Cilj
Cilj te vaje je, da študenti implementirajo mobilno aplikacijo z uporabo Flutter ogrodja, ki omogoča vnos in pregled podatkov o zaposlenih.

## Navodila

1. **Namestitev Flutterja**:
    - Sledite uradnim [navodilom za namestitev Flutterja](https://flutter.dev/docs/get-started/install).

2. **Ustvarjanje novega projekta**:
    - Uporabite ukaz `flutter create ime_projekta` za ustvarjanje novega Flutter projekta.

3. **Struktura aplikacije**:
    - Aplikacija naj vsebuje naslednje zaslone:
      - **Seznam zaposlenih**: Prikazuje seznam vseh vnesenih zaposlenih.
      - **Dodaj zaposlenega**: Omogoča vnos podatkov o novem zaposlenem (ime, priimek, delovno mesto, email).

4. **Model podatkov**:
    - Ustvarite razred `Employee` z atributi: `firstName`, `lastName`, `position`, `email`.

5. **Shranjevanje podatkov**:
    - Podatke o zaposlenih shranjujte lokalno v aplikaciji (npr. z uporabo `List<Employee>`).

6. **Uporabniški vmesnik**:
    - Uporabite Flutterjeve gradnike za oblikovanje uporabniškega vmesnika.
    - Poskrbite za validacijo vnosnih polj (npr. preverjanje pravilnosti email naslova).

7. **Nadgradnja z uporabo Hive**:
    - Namestite Hive in Hive Flutter pakete z uporabo ukaza `flutter pub add hive hive_flutter`.
    - Inicializirajte Hive v vaši aplikaciji.
    - Ustvarite Hive adapter za razred `Employee`.
    - Shranjujte in pridobivajte podatke o zaposlenih z uporabo Hive baze.

## Dodatni viri
- [Flutter dokumentacija](https://flutter.dev/docs)
- [Flutter primeri](https://flutter.dev/docs/cookbook)
- [Hive dokumentacija](https://docs.hivedb.dev/#/)
