# The notebook directory can be mounted in during docker run.
# If not, create it here.
notebook_dir=/home/jovyan/notebooks
if [ ! -e $notebook_dir ]; then
  mkdir -p $notebook_dir
fi
