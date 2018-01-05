/**
 * 
 */
package com.fubon.data;

import java.util.Set;

/**
 * @author fuming.tsai
 *
 */
public class Node {
    public Set<Node> childNode;
    private String name;
    private NodeType nodeType;
    public void setNodeType(NodeType t){this.nodeType=t;}
    public NodeType getNodeType(){return this.nodeType;}
    public void setName(String name){this.name=name;}
    public String getName() {return name;}
    public Node(NodeType type, String name){this.setNodeType(type);this.setName(name);}
    public void setChildNodes(Set<Node> childs){
        this.childNode=childs;
    }
    public Set<Node> getChildNodes(Set<Node> childs){
        return childNode;
    }
}
