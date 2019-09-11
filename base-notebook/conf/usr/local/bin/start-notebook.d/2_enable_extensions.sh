# nbgallery extensions can be turned on by setting environment variables at startup

if [[ "$NBGALLERY_ENABLE_AUTODOWNLOAD" == "yes" || "$NBGALLERY_ENABLE_AUTODOWNLOAD" == "1" ]]; then
  echo 'Enabling nbgallery autodownload extension'
  jupyter nbextension enable --section tree jupyter_nbgallery/autodownload/autodownload
fi

if [[ "$NBGALLERY_ENABLE_EASY_BUTTONS" == "yes" || "$NBGALLERY_ENABLE_EASY_BUTTONS" == "1" ]]; then
  echo 'Enabling nbgallery easy buttons extension'
  jupyter nbextension enable --section notebook jupyter_nbgallery/easy_buttons/easy_buttons
fi

if [[ "$NBGALLERY_ENABLE_INSTRUMENTATION" == "yes" || "$NBGALLERY_ENABLE_INSTRUMENTATION" == "1" ]]; then
  echo 'Enabling nbgallery instrumentation extension'
  jupyter nbextension enable --section notebook jupyter_nbgallery/instrumentation/instrumentation
fi

