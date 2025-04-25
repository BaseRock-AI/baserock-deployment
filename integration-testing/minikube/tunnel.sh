echo "Starting Minikube tunnel..."
sudo minikube tunnel || exit
if [ $? -ne 0 ]; then
  echo "Minikube tunnel failed."
  exit 1
fi

echo "All steps completed successfully."