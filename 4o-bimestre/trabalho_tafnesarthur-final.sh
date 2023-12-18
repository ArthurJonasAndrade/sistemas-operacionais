#!/bin/bash

# Função para autenticação biométrica simulada
function autenticar_biometria() {
    dialog --infobox "Por favor, faça sua autenticação biométrica (simulação)..." 5 50
    sleep 2
    # Lógica de autenticação biométrica aqui (pode ser um leitor de digitais fictício)
    dialog --msgbox "Autenticação bem-sucedida!" 5 30
}

# Função para exibição de informações da conta
function exibir_informacoes_conta() {
    clear
    dialog --title "Itaú Revolution" --infobox "\
    Nome: João da Silva\n\
    Saldo: R$ 10.000,00\n\
    Recompensas: 100 pontos" 8 50
}

# Função para pagamentos por reconhecimento facial
function pagamento_reconhecimento_facial() {
    dialog --yesno "Deseja fazer um pagamento por reconhecimento facial?" 8 40

    if [ $? -eq 0 ]; then
        dialog --infobox "Realizando pagamento por reconhecimento facial..." 5 50
        sleep 2
        dialog --msgbox "Pagamento concluído com sucesso!" 5 30
    else
        dialog --msgbox "Operação cancelada." 5 30
    fi
}

# Função para consultar saldo
function consultar_saldo() {
    dialog --infobox "Consultando saldo..." 5 30
    sleep 2
    exibir_informacoes_conta
}

# Função principal
function main() {
    dialog --yesno "Bem-vindo ao Itaú Revolution. Deseja continuar?" 8 40

    # Verificar a escolha do usuário
    if [ $? -eq 0 ]; then
        autenticar_biometria

        # Se a autenticação for bem-sucedida, exibir informações da conta
        if [ $? -eq 0 ]; then
            exibir_informacoes_conta

            # Estrutura de repetição for
            for i in {1..3}; do
                pagamento_reconhecimento_facial
            done

            # Estrutura de repetição while
            tentativas=0
            while [ $tentativas -lt 2 ]; do
                autenticar_biometria
                if [ $? -eq 0 ]; then
                    exibir_informacoes_conta
                    break
                else
                    ((tentativas++))
                fi
            done

            # Estrutura de repetição until
            tentativas=0
            until [ $tentativas -ge 2 ]; do
                autenticar_biometria
                if [ $? -eq 0 ]; then
                    exibir_informacoes_conta
                    break
                else
                    ((tentativas++))
                fi
            done

            # Estrutura case
            dialog --menu "Escolha uma opção:" 10 40 4 1 "Consultar Saldo" 2 "Realizar Pagamento" 3 "Sair" 2> escolha_usuario
            case $(<escolha_usuario) in
                1)
                    consultar_saldo
                    ;;
                2)
                    pagamento_reconhecimento_facial
                    ;;
                3)
                    dialog --msgbox "Saindo..." 5 30
                    ;;
            esac

        else
            dialog --msgbox "Autenticação falhou. Saindo..." 6 30
        fi
    else
        dialog --msgbox "Operação cancelada. Saindo..." 6 30
    fi
}

# Iniciar o programa
main