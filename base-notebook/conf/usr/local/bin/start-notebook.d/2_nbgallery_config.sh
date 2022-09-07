# nbgallery general configuration

if [[ -n "$NBGALLERY_URL" ]]; then
  echo "Setting nbgallery URL to $NBGALLERY_URL"
  jupyter nbgallery --sys-prefix configure url "$NBGALLERY_URL"
fi

if [[ -n "$NBGALLERY_CLIENT_NAME" ]]; then
  echo "Setting nbgallery client name to $NBGALLERY_CLIENT_NAME"
  jupyter nbgallery --sys-prefix configure client.name "$NBGALLERY_CLIENT_NAME"
fi

if [[ -n "$NBGALLERY_CLIENT_TYPE" ]]; then
  echo "Setting nbgallery client type to $NBGALLERY_CLIENT_TYPE"
  jupyter nbgallery --sys-prefix configure client.type "$NBGALLERY_CLIENT_TYPE"
fi


# nbgallery extensions can be turned on by setting environment variables at startup

if [[ "$NBGALLERY_ENABLE_AUTODOWNLOAD" == "yes" || "$NBGALLERY_ENABLE_AUTODOWNLOAD" == "1" ]]; then
  echo 'Enabling nbgallery autodownload extension'
  #jupyter nbclassic extension enable --sys-prefix --section tree jupyter_nbgallery/autodownload/autodownload
fi

if [[ "$NBGALLERY_ENABLE_EASY_BUTTONS" == "yes" || "$NBGALLERY_ENABLE_EASY_BUTTONS" == "1" ]]; then
  echo 'Enabling nbgallery easy buttons extension'
  #jupyter nbclassic extension enable --sys-prefix --section notebook jupyter_nbgallery/easy_buttons/easy_buttons
  jupyter nbgallery --sys-prefix configure easy_buttons True
fi

if [[ "$NBGALLERY_ENABLE_INSTRUMENTATION" == "yes" || "$NBGALLERY_ENABLE_INSTRUMENTATION" == "1" ]]; then
  echo 'Enabling nbgallery instrumentation extension'
  #jupyter nbclassic nbextension enable --sys-prefix --section notebook jupyter_nbgallery/instrumentation/instrumentation
fi

