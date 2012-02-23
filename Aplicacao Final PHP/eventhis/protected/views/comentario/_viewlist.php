<div class="view">
        <table>
                <tr>
                        <td width="50">
                                <?php 
                                        $user = Utilizador::getUserById($data->utilizador_oid);
                                        echo CHtml::imageButton('.\\'.$user->teste,array(
                                                                                'width'=>50,
                                                                                'height'=>50
                                                                            )
                                        );
                                ?>
                        </td>
                        <td style="float:left;">
                                <?php echo $user->username; ?> diz,
                                <br/>
                                <b><?php echo CHtml::encode($data->texto); ?></b>
                        </td>
                </tr>
        </table>
</div>