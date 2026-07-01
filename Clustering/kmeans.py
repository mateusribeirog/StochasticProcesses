import numpy as np


class Kmedias:
    def __init__(self, num_clusters, num_iter, dist_type):
        self.num_clusters = num_clusters
        self.iter = num_iter
        self.inv_cov = None
        self.dist_type = dist_type
        self.centroides = None

    def train(self, X):
        if self.dist_type == "mahalanobis":
            cov = np.cov(X, rowvar=False)
            try:
                self.inv_cov = np.linalg.inv(cov)
            except np.linalg.LinAlgError:
                self.inv_cov = np.linalg.pinv(
                    cov
                )  # Usa pseudo inversa como contingencia

        # Define os centroides iniciais selecionando pontos aleatorios do conjunto
        np.random.seed(23)
        indices_iniciais = np.random.choice(
            X.shape[0], self.num_clusters, replace=False
        )
        self.centroides = X[indices_iniciais]

        for _ in range(self.iter):
            centroides_anteriores = self.centroides.copy()

            # Agrupa os pontos aos centroides correspondentes
            labels = self._atribuir_clusters(X)

            # Reposiciona os centroides calculando a media de cada grupo
            self.centroides = self._atualizar_centroides(X, labels)

            if np.all(centroides_anteriores == self.centroides):
                break

        return labels, self.centroides

    def _atribuir_clusters(self, X):
        labels = []
        for ponto in X:
            distancias = []
            for centroide in self.centroides:
                if self.dist_type == "euclidian":
                    dist = self._euclidian(ponto, centroide)
                elif self.dist_type == "mahalanobis":
                    dist = self._mahalanobis(ponto, centroide)
                distancias.append(dist)

            # Salva a posicao do centroide que apresentou a menor distancia
            labels.append(np.argmin(distancias))

        return np.array(labels)

    def _atualizar_centroides(self, X, labels):
        novos_centroides = np.zeros((self.num_clusters, X.shape[1]))
        for k in range(self.num_clusters):
            pontos_do_grupo = X[labels == k]

            # Protege o calculo contra grupos sem elementos
            if len(pontos_do_grupo) > 0:
                novos_centroides[k] = np.mean(pontos_do_grupo, axis=0)
            else:
                novos_centroides[k] = self.centroides[k]

        return novos_centroides

    def _euclidian(self, p1, p2):
        return np.sqrt(np.sum((p1 - p2) ** 2))

    def _mahalanobis(self, p1, p2):
        diff = np.array(p1) - np.array(p2)
        # Multiplicacao de matrizes
        dist = np.sqrt(np.dot(np.dot(diff, self.inv_cov), diff.T))
        return dist
