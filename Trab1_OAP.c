#include <stdio.h>

int sqrt(int x, int i)
{
    if (!x)
        return 0;

    if (!i)
        return x;

    return (sqrt(x, i - 1) + (x / sqrt(x, i - 1))) >> 1;
}

int main() {
    int x = 0, i = 0;

    printf("Programa de Raiz Quadrada - Newton-Raphson\n");
    printf("Desenvolvedores: Eduardo Acauan, Fernando Acauan, Henrique Hiller, Rodrigo Pacheco\n");

    while (1) {
        printf("Digite os parametros x e i para calcular sqrt_nr (x, i) ou -1 para abortar a execucao\n");

        scanf("%d", &x);
        if (x < 0) return 0;

        scanf("%d", &i);
        if (i < 0) return 0;

        printf("sqrt(%d,%d)=%d\n", x, i, sqrt(x, i));
    }
    return 0;
}