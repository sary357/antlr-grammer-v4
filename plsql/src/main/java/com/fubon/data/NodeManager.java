/**
 * 
 */
package com.fubon.data;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;
import java.util.TreeSet;

/**
 * @author fuming.tsai
 *
 */
public class NodeManager {
    private List<Node> nodeList;
    private Set<String> physicalTableSet;
    private Set<String> tempTableSet;
        
    public void addNodeRelation(Node parentNode, Node childNode){
        parentNode.setName(parentNode.getName().toUpperCase().trim());
        childNode.setName(childNode.getName().toUpperCase().trim());
        if(!isExist(parentNode)){
            this.addTableSet(parentNode);
            this.nodeList.add(parentNode);
        }
        if(!isExist(childNode)){
            this.addTableSet(childNode);
            this.nodeList.add(childNode);
        }
        Node p=getNodeFromList(parentNode.getName());
        Node c=getNodeFromList(childNode.getName());
        p.addChildNode(c);  
    }
    
    @Override
    public String toString(){
        Set<Node> resultSet=null;
        Set<String> finalResult=new TreeSet<String>();
        if(nodeList!=null && nodeList.size()>0 ){
            for(Node n: nodeList){
                if(n.getName().indexOf("$")<0 && n.getChildNodeSet()!=null && n.getChildNodeSet().size()>0){ // if node is not a temp node
                    resultSet=getChildPhysicalNodeDFS(n);
                    if(resultSet!=null && resultSet.size()>0){
                        for(Node node: resultSet){
                            finalResult.add(n.getName()+","+node.getName());
                        }
                    }
                }
            }
        }

        String rtnStr="";
        for(String s: finalResult){
            rtnStr=rtnStr+s+"\n";
        }
        return rtnStr;
    }
    
    private Set<Node> getChildPhysicalNodeDFS(Node node){
        Set<Node> s=node.getChildNodeSet();
        Set<Node> result=new HashSet<Node>();
        for(Node n:s){
            if(!node.getName().equalsIgnoreCase(n.getName())){
                if(n.getName().indexOf("$")>=0 && n.getChildNodeSet()!=null && n.getChildNodeSet().size()>0){
                    result.addAll(getChildPhysicalNodeDFS(n)); // temp table
                }else{
                    //try{
                    
                    result.add(n);// physical table
                    
                    
                }
            }
        }
        return result;
    }
    private Node getNodeFromList(String name){
       for(Node n: nodeList){
           if(n.getName().toUpperCase().equalsIgnoreCase(name.toUpperCase()))
               return n;
       }
       return null;
    }
    
    private boolean isExist(Node node){        
       if(physicalTableSet.contains(node.getName().toUpperCase()))
           return true;
       if(tempTableSet.contains(node.getName().toUpperCase()))
           return true;     
       return false;
    }
    
    public NodeManager(){
       nodeList=new ArrayList<Node>();
       physicalTableSet=new HashSet<String>();
       tempTableSet=new HashSet<String>();
    }
    
    private void addTableSet(Node n){
       if(n.getName().indexOf("$")>=0){
           tempTableSet.add(n.getName().toUpperCase());
       }else{
           physicalTableSet.add(n.getName().toUpperCase());
       }
    }
    
    public List<Node> getNodeList(){
       return nodeList;
    }
    
    public void setNodeList(List<Node> nodeList){this.nodeList=nodeList;}
    public void removeAll(){
       if(nodeList!=null && nodeList.size()>0)
           for(int index=0 ; index<nodeList.size(); index++)
               nodeList.remove(0);     
        
       physicalTableSet=null;
       tempTableSet=null;
       
        
    }
}
