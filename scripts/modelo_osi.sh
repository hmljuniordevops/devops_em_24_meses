echo "##################################################################"
echo "                             Modelo OSI                    "
echo "##################################################################"
echo "   Menu de opções para o modelo OSI"
echo "Opcao 1: Camada Física"
echo "Opcao 2: Camada de Enlace de Dados"
echo "Opcao 3: Camada de Rede"
echo "Opcao 4: Camada de Transporte"
echo "Opcao 5: Camada de Sessão"
echo "Opcao 6: Camada de Apresentação"
echo "Opcao 7: Camada de Aplicação"
read -p "SELECIONE A OPCÇÃO DESEJADA: " opcao

case $opcao in
    1)
        printf  "Camada Física: Responsável pela transmissão de bits através de um meio físico.\n"
        printf  "Abaixo será exibido as características de sua interface de rede:\n"
        interface=$(ip route | grep default | awk '{print $5}')
        printf  "%s Interface detectada: $interface \n"
        if [ -d "/sys/class/net/$interface/wireless" ]; then
            printf "Tipo de conexão: Wireless"
            iw dev $interface link
        else
            printf  "Tipo de conexão: Ethernet \n"
            ethtool $interface
        fi
        ;;
    2)
        printf "Camada de Enlace de Dados: Responsável pela transferência de dados entre nós adjacentes em uma rede."
        ;;
    3)
        printf "Camada de Rede: Responsável pelo roteamento e encaminhamento de pacotes entre redes."
        ;;
    4)
        echo "Camada de Transporte: Responsável pela entrega confiável de dados entre hosts."
        ;;
    5)
        printf "Camada de Sessão: Responsável pelo estabelecimento, gerenciamento e término de sessões entre aplicações."
        ;;
    6)
        printf "Camada de Apresentação: Responsável pela formatação e tradução dos dados para a aplicação."
        ;;
    7)
        printf "Camada de Aplicação: Responsável por fornecer serviços de rede diretamente para as aplicações do usuário."
        ;;
    *)
        printf "Opção inválida. Por favor, selecione uma opção válida."
        ;;
esac