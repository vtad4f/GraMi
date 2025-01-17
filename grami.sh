#default value not to set the maximum number of label appearances
labels=-1
#default value for bounded distance threshold
distance=1
#default value for approximation, no approximation
alpha=1
beta=0

#parse the parameters
while test $# -gt 0; do
   case "$1" in
      -h|--help)
         echo "GraMi help"
         echo " "
         echo "-h, --help  show brief help"
         echo "-f,         graph filename (*.lg)"
         echo "-s,         minimum frequency"
         echo "-t,         graph type: 0 for undirected graphs, 1 for directed graph"
         echo "-p,         mining type: 0 for subgraphs mining, 1 for patterns graph"
         echo "-d,         distance threshold, only valid for patterns"
         echo "-l,         maximum number of repetitions allowed for each distinct label in the frequent subgraphs/patterns results"
         echo "-approxA,         approximation parameter Alpha"
         echo "-approxB,         approximation parameter Beta"
         echo " "
         exit 0
         ;;
      -f)
         shift
         if test $# -gt 0; then
                        file=$1
         fi
         shift
         ;;
      -s)
         shift
         if test $# -gt 0; then
                        frequency=$1
         fi
         shift
         ;;
      -t)
         shift
         if test $# -gt 0; then
                        type=$1
         fi
         shift
         ;;
      -p)
         shift
         if test $# -gt 0; then
                        patterns=$1
         fi
         shift
         ;;
      -d)
         shift
         if test $# -gt 0; then
                        distance=$1
         fi
         shift
         ;;
      -l)
         shift
         if test $# -gt 0; then
                        labels=$1
         fi
         shift
         ;;
      -approxA)
         shift
         if test $# -gt 0; then
                        alpha=$1
         fi
         shift
         ;;
      -approxB)
         shift
         if test $# -gt 0; then
                        beta=$1
         fi
         shift
         ;;
      *)
         break
         ;;
   esac
done

#printing some output to the users
echo "Dataset: $file"

if [[ $type -eq 1 ]]
then
echo "[DIRECTED]"
else
echo "[UNDIRECTED]"
fi

if [[ $patterns -eq 1 ]]
then
echo "Frequenct Pattern Mining, with minimum distance: $distance"
else
echo "Frequent Subgraph Mining"
fi

if [[ $labels -eq -1 ]]
then
echo "No constraints on labels"
else
echo "Maximum number of label repetition in results: $labels"
fi

echo "Minimum frequency: $frequency"

#specify which application to run and application parameters
#Grami Directed Patterns
if [[ $type -eq 1 ]] && [[ $patterns -eq 1 ]]; then
prog="GRAMI_DIRECTED_PATTERNS"
fi

#Grami Directed Subgraphs
if [[ $type -eq 1 ]] && [[ $patterns -eq 0 ]]; then
prog="GRAMI_DIRECTED_SUBGRAPHS"
fi

#Grami Undirected Patterns
if [[ $type -eq 0 ]] && [[ $patterns -eq 1 ]]; then
prog="GRAMI_UNDIRECTED_PATTERNS"
fi

#Grami Undirected Subgraphs
if [[ $type -eq 0 ]] && [[ $patterns -eq 0 ]]; then
prog="GRAMI_UNDIRECTED_SUBGRAPHS"
fi

echo $prog

#Running Grami
echo "Starting GraMi ...";
java -cp ./$prog/bin Dijkstra.main freq=$frequency filename=$file datasetFolder=./Datasets/ distance=$distance type=$type mlabels=false maxLabelAppearance=$labels approximate=$alpha approxConst=$beta
echo "GraMi Finished."
