# Gammu MySQL Database

This repository provides a **MySQL/MariaDB database schema and Docker setup** for [Gammu SMSD](https://wammu.eu/docs/manual/smsd/).
It is used to store incoming and outgoing SMS messages when Gammu SMSD is running inside a container or directly on a server.

---

## Features

- Predefined database schema for Gammu SMSD
- Ready-to-use Docker Compose setup
- Configurable via `.env` file
- Persists messages (inbox, outbox, sent, failed, etc.) in a MySQL/MariaDB database

---

## Prerequisites

- Docker and Docker Compose installed
- Optional: a common Docker network if you also want to containerize the **Gammu SMSD** service

👉 If you plan to run `gammu-smsd` in a container, create the network:

```bash
./create_sms_services_network.sh
````

👉 If you plan to run `gammu-smsd` directly on the host,
you can **comment out** the `networks` section in the `docker-compose.yml`.

---

## Setup

1. Clone this repository:

   ```bash
   git clone https://github.com/Gasprinskiy/gammu-mysql-db.git
   cd gammu-mysql-db
   ```

2. Create a `.env` file in the root of the project with the following variables:

   ```env
   DB_ROOT_PASSWORD=your_root_password
   DB_NAME=smsdb
   DB_USER=smsuser
   DB_PASSWORD=yourpassword
   ```

3. Start the database container:

   ```bash
   ./start_docker.sh
   ```

   This will run MySQL/MariaDB with the Gammu SMSD schema automatically applied.

---

## Usage

Once the database container is running:

* Configure your `gammu-smsdrc` to connect to this database, for example:

  ```ini
  [smsd]
  service = sql
  driver = native_mysql
  host = gammu-mysql-db
  user = smsuser
  password = yourpassword
  database = smsdb
  ```

* Gammu SMSD will then store all incoming/outgoing SMS in this database.

If you also need to run **Gammu SMSD** in a container, use the companion repository:
📦 [gammu-smsd-container](https://github.com/Gasprinskiy/gammu-smsd-container)

---

## Data Persistence

The database container uses a Docker volume to persist data, so your SMS history will not be lost if the container is restarted.

