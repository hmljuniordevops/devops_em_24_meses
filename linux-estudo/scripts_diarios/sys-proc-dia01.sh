#!/bin/bash

LOG="/var/log/sysmon.log"

echo "=============================="
echo "📊 MONITORAMENTO DO SISTEMA"
echo "=============================="

# 🌡️ TEMPERATURA (sys)
TEMP_PATH="/sys/class/thermal/thermal_zone0/temp"

if [ -f "$TEMP_PATH" ]; then
    TEMP=$(( $(cat $TEMP_PATH) / 1000 ))
    echo "🌡️ CPU Temp: ${TEMP}°C"
else
    TEMP="N/A"
    echo "🌡️ CPU Temp: não disponível"
fi

# 🧠 MEMÓRIA (proc)
MEM_TOTAL=$(grep MemTotal /proc/meminfo | awk '{print $2}')
MEM_AVAIL=$(grep MemAvailable /proc/meminfo | awk '{print $2}')
MEM_USED=$((MEM_TOTAL - MEM_AVAIL))

# ⚙️ CPU USO (proc)
CPU1=($(grep 'cpu ' /proc/stat))
sleep 1
CPU2=($(grep 'cpu ' /proc/stat))

IDLE1=${CPU1[4]}
IDLE2=${CPU2[4]}

TOTAL1=0
TOTAL2=0

for i in "${CPU1[@]:1}"; do TOTAL1=$((TOTAL1 + i)); done
for i in "${CPU2[@]:1}"; do TOTAL2=$((TOTAL2 + i)); done

DIFF_IDLE=$((IDLE2 - IDLE1))
DIFF_TOTAL=$((TOTAL2 - TOTAL1))

CPU_USAGE=$(( (100 * (DIFF_TOTAL - DIFF_IDLE)) / DIFF_TOTAL ))

# 💾 DISCO
DISK=$(df -h / | awk 'NR==2 {print $5}')

# 🌐 REDE
NET=$(ls /sys/class/net | grep -v lo | head -n 1)
STATE=$(cat /sys/class/net/$NET/operstate 2>/dev/null)

# 📊 SAÍDA
echo "🧠 RAM usada: $((MEM_USED/1024)) MB"
echo "⚙️ CPU uso: ${CPU_USAGE}%"
echo "💾 Disco: $DISK"
echo "🌐 Rede ($NET): $STATE"

# 📝 LOG PROFISSIONAL
echo "$(date) | CPU:${CPU_USAGE}% | RAM:$((MEM_USED/1024))MB | TEMP:${TEMP}C | DISK:$DISK | NET:$STATE" >> $LOG
