package web;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by sjzc66 on 2016/11/29.
 */
public class testRount {

    /*public static void main(String[] args) {
        *//*List<Integer> ls = new ArrayList<>();
        ls.add(0);
        ls.add(3);
        ls.add(1);
        ls.add(3);
        for (int i = 0; i < ls.size(); i++) {
            int rtn = testRount.findN(ls,i);
            System.out.println("rtn = " + rtn);
        }*//*

        int[] array = { 2, 1, 2 };
        int[] lsWeight = { 2, 4, 2};
        int[] lsIndex = { 0, 1, 2};

        int index = getIndex(array,lsWeight,lsIndex);
        System.out.println("本次获取的index= " + index);
        System.out.println();
        System.out.println();
    }*/

    public static void main(String[] args) {
        System.out.println("ja" + "va" == "java");

    }

    private static int getIndex(int[] lstPerson,int[] lstWeight,int[] lstIndex){
        System.out.println("Before sort:");
        printArray(lstPerson);
        printArray(lstWeight);
        printArray(lstIndex);

        quickSort(lstPerson,lstIndex,lstWeight);
        //weightSort(lstPerson,lstIndex,lstWeight);

        System.out.println("After sort:");
        printArray(lstPerson);
        printArray(lstWeight);
        printArray(lstIndex);

        return lstPerson[0];
    }

    /*private  static testRount aaa(){
        return new testRount();
    }*/

    private static void weightSort(int[] lsData,int[] lsWeight,int[] lsIndex){
        for (int i = 0; i < lsData.length - 2 ; i++) {
            for (int j = i+1 ; j < lsData.length - 1 ; j++){
                if (lsData[i] == lsData[j] && lsWeight[i] > lsWeight[j]){
                    exchangeElements(lsData,lsWeight,lsIndex,i,j);
                }
            }
        }
    }

    private static void exchangeElements(List<Integer> array,List<Integer> lsWeight,List<Integer> lsIndex, int index1, int index2) {
        int temp = array.get(index1);
        array.set(index1,array.get(index2));
        array.set(index2,temp);

        temp = lsWeight.get(index1);
        lsWeight.set(index1,lsWeight.get(index2));
        lsWeight.set(index2,temp);

        temp = lsIndex.get(index1);
        lsIndex.set(index1,lsIndex.get(index2));
        lsIndex.set(index2,temp);
    }

    public static void printArray(int[] array) {
        System.out.print("{");
        for (int i = 0; i < array.length; i++) {
            System.out.print(array[i]);
            if (i < array.length - 1) {
                System.out.print(", ");
            }
        }
        System.out.println("}");
    }

    private static int findN(List<Integer> lsData,int n){
        List<Integer> lsIndex = new ArrayList<>();
        for (int i = 0; i < lsData.size(); i++) {
            lsIndex.add(i);
        }

        //quickSort(lsData,lsIndex);
        return lsIndex.get(n);
    }

    public static void quickSort(int[] array,int[] lsIndex,int[] lsWeight) {
        subQuickSort(array,lsIndex,lsWeight, 0, array.length - 1);
    }

    public static void exchangeElements(int[] array,int[] lsIndex,int[] lsWeight, int index1, int index2) {
        int temp = array[index1];
        array[index1] = array[index2];
        array[index2] = temp;

        temp = lsWeight[index1];
        lsWeight[index1] = lsWeight[index2];
        lsWeight[index2] = temp;

        temp = lsIndex[index1];
        lsIndex[index1] = lsIndex[index2];
        lsIndex[index2] = temp;
    }

    private static void subQuickSort(int[] array,int[] lsIndex,int[] lsWeight, int start, int end) {
        if (array == null || (end - start + 1) < 2) {
            return;
        }

        int part = partition(array,lsIndex,lsWeight, start, end);

        if (part == start) {
            subQuickSort(array,lsIndex,lsWeight, part + 1, end);
        } else if (part == end) {
            subQuickSort(array,lsIndex,lsWeight, start, part - 1);
        } else {
            subQuickSort(array,lsIndex,lsWeight, start, part - 1);
            subQuickSort(array,lsIndex,lsWeight, part + 1, end);
        }
    }

    private static int partition(int[] array,int[] lsIndex,int[] lsWeight, int start, int end) {
        int value = array[end];
        int valueWeight = lsWeight[end];
        int index = start - 1;

        for (int i = start; i < end; i++) {
            if (array[i] < value && lsWeight[i] < valueWeight) {
                index++;
                if (index != i) {
                    exchangeElements(array,lsIndex,lsWeight, index, i);
                }
            }
        }

        if ((index + 1) != end) {
            exchangeElements(array,lsIndex,lsWeight, index + 1, end);
        }

        return index + 1;
    }


    /*private static int partition(List<Integer> lstIndex, int first, int last)
    {
        int pivot= lstIndex.get(first);
        while(first < last)
        {
            while(first < last && lstIndex.get(last) > pivot){
                last--;
                lstIndex.set(first,lstIndex.get(last));
            }
            while(first < last && lstIndex.get(first)<pivot){
                first++;
                lstIndex.set(last,lstIndex.get(first));
            }
        }
        lstIndex.set(first,pivot);
        return first;
    }

    private static int findKth(List<Integer> lstIndex,int first,int last,int k)
    {
        int kth;
        if(first == last)  {
            kth = lstIndex.get(first);
        }
        else
        {
            int pivot = lstIndex.get(first);
            int splitPoint = partition(lstIndex,first,last);
            if(k < splitPoint){
                kth=findKth(lstIndex,first,splitPoint-1,k);
            }
            else if( k > splitPoint){
                kth=findKth(lstIndex,splitPoint+1,last,k);
            }
            else {
                kth = pivot;
            }
        }
        return kth;
    }*/
}
