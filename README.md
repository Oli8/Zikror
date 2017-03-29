<h1> <img src="https://gitlab.com/Oli8/Ruby_on_Rails_Projet_Libre/raw/master/app/assets/images/logo-zkr.png" alt="Zikror logo" width="50"/> Zikror </h1>

## Démarrer

1. Installer Rails si ce n'est pas déjà fait:

        $ gem install rails

1. Cloner le dossier:

        $ git clone git@github.com:Oli8/Zikror.git
        $ cd Zikror
        
3. Installer les dépendances:

        $ bundle install

4. Créer la base de données:

        $ rake db:create
        $ rake db:migrate

5. Lancer l'application:

        $ bin/rails s
