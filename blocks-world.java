public class Example1 {

      public static void main(String[] args) throws PlPlanException {

System.out.println(&quot;-- TEST1 --&quot;);<br />
// Create a planning problem, and then find a plan<br />
// This problem is based on Blockworld<br />
PLPlan planner = new PLPlan();<br />
planner.setAlgorithm(EnumAlgorithm.GRAPHPLAN);

// Facts (Initial state) //td, ocd, obc, oab, na
planner.addFact("td"); 
planner.addFact("ocd"); 
planner.addFact("obc"); 
planner.addFact("oab"); 
planner.addFact("na");

        // Goal //( oca, odb, ta, tb, nc, nd)
planner.addGoalFact("oca");
planner.addGoalFact("odb");
planner.addGoalFact("ta");
planner.addGoalFact("tb");
planner.addGoalFact("nc");
planner.addGoalFact("nd");

        // --- Operators ---
//        (op uAB
//                (na, oab)
//                (ta, nb)
//                (oab))
List<String> precond = new ArrayList<String>();
precond.add("na");
precond.add("oab");
List<String> neg = new ArrayList<String>();
neg.add("oab");
List<String> pos = new ArrayList<String>();
pos.add("ta");
pos.add("nb");
planner.addOperator("uAB",precond, neg, pos);

//      (op uBC     //   operator name : "uBC"  unstack block b from block c
//      (nb, obc)   //   predonditions : the b Block is on block c (obc) and 
//                                       there is no block on block b (nb)                                                   
//      (tb, nc)    //   add facts :     the block b is on table (tb)
//                                       there is no block on block c (nc)
//      (obc))      //   remove facts : we remove the fact that
//                                      the b Block is on block c (ocd)
precond = new ArrayList<String>();
precond.add("nb");
precond.add("obc");
neg = new ArrayList<String>();
neg.add("obc");
pos = new ArrayList<String>();
pos.add("tb");
pos.add("nc");
planner.addOperator("uBC",precond, neg, pos);

//        (op uCD             //   operator name : "uCD"  unstack block c from block d
//                (nc, ocd)   //   predonditions : the c Block is on block D (ocd) and 
//                                                 there is no block on block c (nc)                                                   
//                (tc, nd)    //   add facts :     the block c is on table (tc)
//                                                 there is no block on block d (nd)
//                (ocd))      //   remove facts : we remove the fact that
//                                                the c Block is on block d (ocd)
precond = new ArrayList<String>();
precond.add("nc");
precond.add("ocd");
neg = new ArrayList<String>();
neg.add("ocd");
pos = new ArrayList<String>();
pos.add("tc");
pos.add("nd");
planner.addOperator("uCD",precond, neg, pos);

precond = new ArrayList<String>();
precond.add("na");
precond.add("tc");
precond.add("nc");
neg = new ArrayList<String>();
neg.add("na");
neg.add("tc");
pos = new ArrayList<String>();
pos.add("oca");
planner.addOperator("sCA", precond, neg, pos);


precond = new ArrayList<String>();
precond.add("nb");
precond.add("td");
precond.add("nd");
neg = new ArrayList<String>();
neg.add("nb");
neg.add("td");
pos = new ArrayList<String>();
pos.add("odb");
planner.addOperator("sDB", precond, neg, pos);

        List resultats = planner.findPlan();
System.out.println(resultats);
}

}


