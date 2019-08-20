import os
import json

# Set nbgallery location and client name
nbgallery_url = os.getenv('NBGALLERY_URL', 'http://localhost:3000')
client_name = os.getenv('NBGALLERY_CLIENT_NAME', 'nbgallery-client')

# Jupyter settings
c.JupyterApp.ip = '0.0.0.0'
c.JupyterApp.open_browser = False
c.JupyterApp.reraise_server_extension_failures = True

# Notebook directory can be mounted in, or it will be created by startup hook
notebook_dir = os.path.join(os.path.expanduser('~'), 'notebooks')
c.JupyterApp.notebook_dir = notebook_dir

# Security settings required to receive notebooks from nbgallery
c.JupyterApp.allow_origin = nbgallery_url
c.JupyterApp.allow_credentials = True
c.JupyterApp.disable_check_xsrf = True

# Update nbconfig file
config_file = os.path.join(os.path.expanduser('~'), '.jupyter', 'nbconfig', 'common.json')
with open(config_file) as fp:
    config = json.load(fp)
config['nbgallery']['url'] = nbgallery_url
config['nbgallery']['client']['name'] = client_name
with open(config_file, 'w') as fp:
    json.dump(config, fp, indent=2)

