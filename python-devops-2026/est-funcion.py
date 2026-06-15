# def soma(*args):
#     total = 0
#     for numero in args:
#         total += numero
#     return total


# print("a soma é ",soma(1,2,3,4,5))



#exemplo de funcao com kwargs para devops

def criar_servidor(**kwargs):
    for chave,valor in kwargs.items():
        print(f"{chave}: {valor}")


criar_servidor(nome="Servidor1", 
               ip="77.100.100.18.30.23",
               sistema_operacional="Linux",
               ram="16GB",
               cpu= "32 cores")    