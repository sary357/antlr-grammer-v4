/**
 * 
 */
package com.fubon.data;

import java.util.HashSet;
import java.util.Set;
import java.util.TreeSet;

/**
 * @author fuming.tsai
 *
 */
public class Node {
    public Set<Node> childNodeSet;
    
    private String name;
    //private NodeType nodeType;
   // public void setNodeType(NodeType t){this.nodeType=t;}
    //public NodeType getNodeType(){return this.nodeType;}
    public void setName(String name){this.name=name;}
    public String getName() {return name;}
    public Node(String name){this.setName(name);}
    public Node(String owner, String tableName){this.setName(owner+"."+tableName);}
    
    public void addChildNode(Node child){
        boolean isExist=false;
        if(childNodeSet==null){
            childNodeSet=new HashSet<Node>();
        }
        for(Node n: childNodeSet){
            if(n.getName().equalsIgnoreCase(child.getName()))
                isExist=true;
        }
        if(!isExist)
            childNodeSet.add(child);
    }
        
    public Set<Node> getChildNodeSet(){
        return childNodeSet;
    }
}
