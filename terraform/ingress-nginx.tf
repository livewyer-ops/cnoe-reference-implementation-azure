resource "kubectl_manifest" "application_argocd_ingress_nginx" {
  yaml_body = templatefile("${path.module}/templates/argocd-apps/ingress-nginx.yaml", {
    GITHUB_URL = local.repo_url
    }
  )

  provisioner "local-exec" {
    command = "kubectl wait --for=jsonpath=.status.health.status=Healthy --timeout=300s -n argocd application/ingress-nginx"

    interpreter = ["/bin/bash", "-c"]
  }
}
