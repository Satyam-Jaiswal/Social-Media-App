#include <iostream>
#include <stdlib.h>
#include <conio.h>

using namespace std;

struct treeNode
{
    int data;
    treeNode *left;
    treeNode *right;
};

treeNode *Insert(treeNode *node, int data)
{
    if (node == NULL)
    {
        treeNode *temp;
        temp = new treeNode;
        temp->data = data;
        temp->left = temp->right = NULL;
        return temp;
    }
    if (data > (node->data))
    {
        node->right = Insert(node->right, data);
    }
    else if (data < (node->data))
    {
        node->left = Insert(node->left, data);
    }
    return node;
}

treeNode *FindMin(treeNode *node)
{
    if (node == NULL)
    {
        /* There is no element in the tree */
        return NULL;
    }
    else if (node->left)
        /* Go to the left sub tree to find the min element */
        return FindMin(node->left);
    else
        return node;
}

treeNode *Delete(treeNode *node, int data)
{
    treeNode *temp;
    if (node == NULL)
    {
        cout << "Element Not Found";
        return 0;
    }
    else if (data < node->data)
    {
        node->left = Delete(node->left, data);
    }
    else if (data > node->data)
    {
        node->right = Delete(node->right, data);
    }
    else
    {
        /* Now We can delete this node and replace with either minimum element
        in the right sub tree or maximum element in the left subtree */
        if (node->right && node->left)
        {
            /* Here we will replace with minimum element in the right sub tree */
            temp = FindMin(node->right);
            node->data = temp->data;
            /* As we replaced it with some other node, we have to delete that node */
            node->right = Delete(node->right, temp->data);
        }
        else
        {
            /* If there is only one or zero children then we can directly
            remove it from the tree and connect its parent to its child */
            temp = node;
            if (node->left == NULL)
                node = node->right;
            else if (node->right == NULL)
                node = node->left;
            free(temp); /* temp is longer required */
        }
    }
    return node;
}

void Inorder(treeNode *node)
{
    if (node == NULL)
    {
        /* There is no element in the tree */
        return;
    }
    Inorder(node->left);
    cout << node->data << " ";
    Inorder(node->right);
}

void Preorder(treeNode *node)
{
    if (node == NULL)
    {
        /* There is no element in the tree */
        return;
    }
    cout << node->data << " ";
    Preorder(node->left);
    Preorder(node->right);
}

void Postorder(treeNode *node)
{
    if (node == NULL)
    {
        /* There is no element in the tree */
        return;
    }
    Postorder(node->left);
    Postorder(node->right);
    cout << node->data << " ";
}

int main()
{
    treeNode *root = NULL;
    int ch;
    cout << "1.Insert\n";
    cout << "2.Delete\n";
    cout << "3.Inorder\n";
    cout << "4.Preorder\n";
    cout << "5.Postorder\n";
    cout << "6.Exit\n";
    do
    {
        cout << "Enter your choice: ";
        cin >> ch;
        switch (ch)
        {
        case 1:
            cout << "Enter element to be inserted: ";
            cin >> ch;
            root = Insert(root, ch);
            break;
        case 2:
            cout << "Enter element to be deleted: ";
            cin >> ch;
            root = Delete(root, ch);
            break;
        case 3:
            cout << "Inorder Travesal is: ";
            Inorder(root);
            cout << "\n";
            break;
        case 4:
            cout << "Preorder Traversal is: ";
            Preorder(root);
            cout << "\n";
            break;
        case 5:
            cout << "Postorder Traversal is: ";
            Postorder(root);
            cout << "\n";
            break;
        case 6:
            cout << "Exit.";
            break;
        default:
            cout << "Invalid Choice";
        }
    } while (ch != 6);
    return 0;
}
