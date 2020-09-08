# The notebook directory can be mounted in during docker run.
# If not, create it here.
if [ ! -e $NOTEBOOK_DIR ]; then
  mkdir -p $NOTEBOOK_DIR
fi
