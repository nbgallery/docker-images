import json
import os
import sys

from notebook.config_manager import BaseJSONConfigManager
from jupyter_core.paths import jupyter_config_path

# By this point, the nbgallery url should be set in nbconfig/common.json -
# either baked into the docker image or pulled from the environment by
# start-notebook.d/2_nbgallery_config.sh.
def find_nbgallery_url():
    #for config_dir in [os.path.join(p, 'nbconfig') for p in jupyter_config_path()]:
    #    cm = BaseJSONConfigManager(config_dir=config_dir)
    #    config = cm.get('common')
    #    try:
    #        return config['nbgallery']['url']
    #    except:
    #        # keep going
    #        pass
    # Return from environment, or else nbgallery rails default
    return os.getenv('NBGALLERY_URL', 'http://localhost:3000')

# Jupyter settings
c.NotebookApp.ip = '0.0.0.0'
c.NotebookApp.open_browser = False
c.NotebookApp.reraise_server_extension_failures = True

# Notebook directory can be mounted in, or it will be created by startup hook
notebook_dir = os.getenv('NOTEBOOK_DIR')
c.NotebookApp.notebook_dir = notebook_dir

# Security settings required to receive notebooks from nbgallery
nbgallery_url = find_nbgallery_url()
# To support multiple nbgalleries, use allow_origin_pat = 'regex'
c.NotebookApp.allow_origin = nbgallery_url
c.NotebookApp.allow_credentials = True
c.NotebookApp.disable_check_xsrf = True

# Set SameSite cookie options when running secure.
# Ideally we should check if certfile is set, but within this file
# there doesn't seem to be a way to check if it was set elsewhere.
if 'GEN_CERT' in os.environ:
    c.NotebookApp.cookie_options = {"SameSite": "None", "Secure": True}
