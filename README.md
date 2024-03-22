# Agila

Agila is a software that helps you manage your tasks and projects efficiently.  It is extremly early in its development so you might want to wait.

## For Developers

### Running (and developing) Agila

If you want to contribute to Agila or customize it for your own needs, follow these steps:

1. Ensure that you have Visual Studio Code and Docker installed on your machine.
2. Clone the repository on GitHub: `git clone https://github.com/your-username/agila.git`
3. Open Visual Studio Code and add access to the project by navigating to `File > Add Folder to Workspace` and selecting the project directory.
4. Once the project is open in Visual Studio Code, you can start the environment as a development container by clicking on the "Remote Explorer" icon in the sidebar, selecting the project folder, and choosing "Reopen in Container".
5. Install the dependencies by running `bundle install` in the integrated terminal of Visual Studio Code.
6. Start the development server by running `rails server` in the integrated terminal of Visual Studio Code.
7. Open your browser and visit `http://localhost:3000` to access Agila.

Feel free to make changes, add features, and submit pull requests to contribute to the project.

## For Users

### Running Agila

To run Agila using Docker, follow these steps:

1. Clone the repository: `git clone https://github.com/mbeauv/agila.git`
2. Navigate to the project directory: `cd agila`
3. Create an `.env` file by copying the `.env.example` file: `cp .env.example .env`
4. Open the `.env` file and configure the necessary environment variables.
5. Start the Docker containers by running: `docker-compose up`
6. Create the database by running: `docker-compose run web rails db:setup`
7. Run the database migrations by running: `docker-compose run web rails db:migrate`

After completing these steps, Agila should be up and running. You can access it by visiting `http://localhost:8000` in your browser.

